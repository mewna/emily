defmodule Emily.Util do
  # REFERENCE: https://gist.github.com/SinisterRectus/9518f3e7d0d1ccb4335b2a0d389c30b0
  def base_url,                                                   do: "https://discordapp.com/api/v6"
  def gateway,                                                    do: "/gateway"
  def gateway_bot,                                                do: "/gateway/bot"

  def channel(channel_id),                                        do: "/channels/#{channel_id}"
  def channel_messages(channel_id),                               do: "/channels/#{channel_id}/messages"
  def channel_message(channel_id, message_id),                    do: "/channels/#{channel_id}/messages/#{message_id}"
  def channel_reaction_me(channel_id, message_id, emoji),         do: "/channels/#{channel_id}/messages/#{message_id}/reactions/#{emoji}/@me"
  def channel_reaction(channel_id, message_id, emoji, user_id),   do: "/channels/#{channel_id}/messages/#{message_id}/reactions/#{emoji}/#{user_id}"
  def channel_reactions_get(channel_id, message_id, emoji),       do: "/channels/#{channel_id}/messages/#{message_id}/reactions/#{emoji}"
  def channel_reactions_delete(channel_id, message_id),           do: "/channels/#{channel_id}/messages/#{message_id}/reactions"
  def channel_bulk_delete(channel_id),                            do: "/channels/#{channel_id}/messages/bulk_delete"
  def channel_permission(channel_id, overwrite_id),               do: "/channels/#{channel_id}/permissions/#{overwrite_id}"
  def channel_invites(channel_id),                                do: "/channels/#{channel_id}/invites"
  def channel_typing(channel_id),                                 do: "/channels/#{channel_id}/typing"
  def channel_pins(channel_id),                                   do: "/channels/#{channel_id}/pins"
  def channel_pin(channel_id, message_id),                        do: "/channels/#{channel_id}/pins/#{message_id}"

  def guilds,                                                     do: "/guilds"
  def guild(guild_id),                                            do: "/guilds/#{guild_id}"
  def guild_channels(guild_id),                                   do: "/guilds/#{guild_id}/channels"
  def guild_members(guild_id),                                    do: "/guilds/#{guild_id}/members"
  def guild_member(guild_id, user_id),                            do: "/guilds/#{guild_id}/members/#{user_id}"
  def guild_member_role(guild_id, user_id, role_id),              do: "/guilds/#{guild_id}/members/#{user_id}/roles/#{role_id}"
  def guild_bans(guild_id),                                       do: "/guilds/#{guild_id}/bans"
  def guild_ban(guild_id, user_id),                               do: "/guilds/#{guild_id}/bans/#{user_id}"
  def guild_roles(guild_id),                                      do: "/guilds/#{guild_id}/roles"
  def guild_role(guild_id, role_id),                              do: "/guilds/#{guild_id}/roles/#{role_id}"
  def guild_prune(guild_id),                                      do: "/guilds/#{guild_id}/prune"
  def guild_voice_regions(guild_id),                              do: "/guilds/#{guild_id}/regions"
  def guild_invites(guild_id),                                    do: "/guilds/#{guild_id}/invites"
  def guild_integrations(guild_id),                               do: "/guilds/#{guild_id}/integrations"
  def guild_integration(guild_id, integration_id),                do: "/guilds/#{guild_id}/integrations/#{integration_id}"
  def guild_integration_sync(guild_id, integration_id),           do: "/guilds/#{guild_id}/integrations/#{integration_id}/sync"
  def guild_embed(guild_id),                                      do: "/guilds/#{guild_id}/embed"

  def webhooks_guild(guild_id),                                   do: "/guilds/#{guild_id}/webhooks"
  def webhooks_channel(channel_id),                               do: "/channels/#{channel_id}/webhooks"
  def webhook(webhook_id),                                        do: "/webhooks/#{webhook_id}"
  def webhook_token(webhook_id, webhook_token),                   do: "/webhooks/#{webhook_id}/#{webhook_token}"
  def webhook_git(webhook_id, webhook_token),                     do: "/webhooks/#{webhook_id}/#{webhook_token}/github"
  def webhook_slack(webhook_id, webhook_token),                   do: "/webhooks/#{webhook_id}/#{webhook_token}/slack"

  def user(user_id),                                              do: "/users/#{user_id}"

  def me,                                                         do: "/users/@me"
  def me_guilds,                                                  do: "/users/@me/guilds"
  def me_guild(guild_id),                                         do: "/users/@me/guilds/#{guild_id}"
  def me_channels,                                                do: "/users/@me/channels"
  def me_connections,                                             do: "/users/@me/connections"

  def invite(invite_code),                                        do: "/invites/#{invite_code}"
  def regions,                                                    do: "/voice/regions"

  def application_information,                                    do: "/oauth2/applications/@me"

  def channel_permissions(chanID),                                do: "/channels/#{chanID}/permissions"
  def channels,                                                   do: "/channels"
  def channel_call_ring(channel_id),                              do: "/channels/#{channel_id}/call/ring"
  def group_recipient(group_id, user_id),                         do: "/channels/#{group_id}/recipients/#{user_id}"
  def guild_me_nick(guild_id),                                    do: "/guilds/#{guild_id}/members/@me/nick"
  
  def now do
    DateTime.utc_now
    |> DateTime.to_unix(:milliseconds)
  end
end