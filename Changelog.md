12-16

Plugins Updates:

SurfTimer (2.2):
Added point system explanation
Added tier option to map settings menu
Added ranked option to map settings menu
Added style ranking system (points for styles)
Added style sub-menu to commands such as sm_wr sm_wrb sm_mtop sm_wrcp
Fixed up profile menus for new style rankings
Removed credits being given out when finishing a map
Added sm_replay which allows players to play a replay of any style
Added ConVar ck_play_replay_vip_only sets whether the sm_replay command can only be used by VIPs (Disable/Enable)
Fixed a issue with manual recalcuation
Various translation file fixes
Fixed zoner and adminmenu flag ConVars not working
Added ConVar to change the sound for wr ck_sp_wr
Added ConVar to change the sound for top 10 ck_sp_top
Added ConVar to change the sound for pb ck_sp_pb
Added ConVar to change the sound for wrcp ck_sp_wrcp
Removed constant call to db_viewTotalStages causing database slowdowns
Changed All PrintToChat & ReplyToCommand to CPrintToChat & CReplyToCommand
Moved (almost) every CPrintToChat & CReplyToCommand to the translation file
Regulated tabs and spaces throughout the files
Added configurable chat prefix option


SlopeFix:
Fix for slopes with trigger_pushes.

Auto-File-Loader (1.0.3):
Moved the functionality from OnConfigsExecuted to OnMapStart instead.

Chat-Processor
Added a plugin to fix backwards compatibility for SCP plugins. (NOT TESTED)

Sm-Skin-Chooser (4.9)
Changed precaching , THX Valve.