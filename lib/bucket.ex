defmodule Emily.Bucket do
  alias Emily.Util
  alias Lace.Redis

  def create_bucket(route, remaining, reset_time, latency) do
    #:ets.insert(:ratelimit_buckets, {route, remaining, reset_time, latency})
    Redis.q ["SET", "route:#{route}:remaining", remaining]
    Redis.q ["SET", "route:#{route}:reset_time", reset_time]
    Redis.q ["SET", "route:#{route}:latency", latency]
  end

  defp get_bucket(route) do
    {:ok, remaining} = Redis.q ["GET", "route:#{route}:remaining"]
    {:ok, reset_time} = Redis.q ["GET", "route:#{route}:reset_time"]
    {:ok, latency} = Redis.q ["GET", "route:#{route}:latency"]
    {route, remaining, reset_time, latency}
  end

  def lookup_bucket(route) do
    #route_time = :ets.lookup(:ratelimit_buckets, route)
    #global_time = :ets.lookup(:ratelimit_buckets, "GLOBAL")

    #Enum.max([route_time, global_time])

    route_time = get_bucket route
    global_time = get_bucket "GLOBAL"
    # If there's a global ratelimit, then respect it. Otherwise, per-route 
    # ratelimits.
    case global_time do
      {"GLOBAL", :undefined, :undefined, :undefined} -> [route_time]
      _ -> [global_time]
    end
  end

  def update_bucket(route, remaining) do
    #:ets.update_element(:ratelimit_buckets, route, {2, remaining})
    Redis.q ["SET", "route:#{route}:remaining", remaining]
  end

  def delete_bucket(route) do
    #:ets.delete(:ratelimit_buckets, route)
    Redis.q ["DEL", "route:#{route}:remaining"]
    Redis.q ["DEL", "route:#{route}:reset_time"]
    Redis.q ["DEL", "route:#{route}:latency"]
  end

  def get_ratelimit_timeout(route) do
    case lookup_bucket(route) do
      [] ->
        # No ratelimit data at all
        :none
      [{route, remaining, reset_time, latency}] when remaining <= 0 ->
        update_bucket(route, remaining - 1)
        wait_time = reset_time - Util.now + latency
        if wait_time <= 0 do
          # Wait time over, delete the bucket and send
          delete_bucket(route)
          nil
        else
          # Gotta wait :<
          wait_time
        end
      [{route, remaining, _reset_time, _latency}] ->
        # We have requests remaining, might as well send
        update_bucket(route, remaining - 1)
        nil
    end
  end
end
