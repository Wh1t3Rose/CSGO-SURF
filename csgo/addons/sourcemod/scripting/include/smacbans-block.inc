#if defined _smacbans_block_included
	#endinput
#endif
#define _smacbans_block_included




// Taken from smlib, blame them if it's too short :3
#define MAX_STEAMAUTH_LENGTH 21




/**
 * Prints a chatmessage to a all admins with a given adminflag or override.
 *
 * @param admflag       Adminflag.
 * @param format        Formatting rules.
 * @param ...           Variable number of format parameters.
 * @noreturn
*/
stock SmacbansPrintAdminNotice(admflag, const String:format[], any:...)
{
	decl String:Message[192];
	
	for(new i; i <= MaxClients; i++)
	{
		if(SmacbansIsClientValid(i))
		{
			if(CheckCommandAccess(i, "smacbans_admin", admflag, false))
			{
				SetGlobalTransTarget(i);
				VFormat(Message, sizeof(Message), format, 3);
				PrintToChat(i, Message);
			}
		}
	}
}




/**
 * Prints an debugmessage to the serverconsole and all ingame players.
 *
 * @param enabled       Bool value to enable/disable this function.
 * @param format        Formatting rules.
 * @param ...           Variable number of format parameters.
 * @noreturn
*/
stock SmacbansDebug(bool:enabled, const String:format[], any:...)
{
	if(enabled)
	{
		decl String:Message[4096];
		VFormat(Message, sizeof(Message), format, 3);
		
		PrintToServer(Message);
		PrintToChatAll(Message);
	}
}




/**
 * Returns if a given clientindex is within the range of being a client.
 *
 * @param client        Client index.
 * @return              True if client is usable, false otherwise.
*/
stock bool:SmacbansIsClientUsable(client)
{
	if(client > 0 && client <= MaxClients)
	{
		return true;
	}
	
	return false;
}




/**
 * Returns if a given client is authorized and usable.
 *
 * @param client        Client index.
 * @return              True if client is authorized and usable, false otherwise.
*/
stock bool:SmacbansIsClientUsableAuth(client)
{
	if(client > 0 && client <= MaxClients && IsClientAuthorized(client))
	{
		return true;
	}
	
	return false;
}




/**
 * Returns if a given client is valid (ingame).
 *
 * @param client        Client index.
 * @return              True if client is valid, false otherwise.
*/
stock bool:SmacbansIsClientValid(client)
{
	if(client > 0 && client <= MaxClients && IsClientInGame(client))
	{
		return true;
	}
	
	return false;
}




/**
 * Finds a client matching the given AuthID.
 *
 * @param auth          AuthID.
 * @return              Clientindex or -1 on failure.
*/
// Used to find a matching client to an auth
stock SmacbansGetClientFromSteamId(const String:auth[])
{
	new String:clientAuth[MAX_STEAMAUTH_LENGTH];
	
	for(new i; i <= MaxClients; i++) 
	{
		if(SmacbansIsClientUsableAuth(i) && !IsFakeClient(i))
		{
			GetClientAuthString(i, clientAuth, sizeof(clientAuth));
			
			if(StrEqual(auth, clientAuth)) 
			{
				return i;
			}
		}
	}
	
	return -1;
}




/**
 * Formats an long to an dotted IP-string
 *
 * @param long          Long ip.
 * @param str           String to store the ip into.
 * @param maxlen        Length of buffer.
 * @noreturn
 */
stock SmacbansLongToIp(long, String:str[], maxlen)
{
	new pieces[4];
	
	pieces[0] = (long >>> 24 & 255);
	pieces[1] = (long >>> 16 & 255);
	pieces[2] = (long >>> 8 & 255);
	pieces[3] = (long & 255); 
	
	Format(str, maxlen, "%d.%d.%d.%d", pieces[0], pieces[1], pieces[2], pieces[3]); 
}




// Banstatus
#define BANSTATUS_UNKNOWN    0
#define BANSTATUS_NOT_BANNED 1
#define BANSTATUS_IS_BANNED  2




/**
 * Called after the status of an steamid was retrieved.
 * Note: It is not gauranteed that the owner of the auth is available at this time.
 *    [- Use the included stock to find and validate the owner of the auth.
 *
 * @param auth          Authid response.
 * @param banstatus     Banstatus of the auth.
 * @param banreason     Banreason if banned.
 * @noreturn
 */
forward SmacBans_OnSteamIDStatusRetrieved(const String:auth[], banstatus, const String:banreason[]);




/**
 * Called after the status of a banned steamid was retrieved and the owner is about to be kicked.
 * Note: Only gets called if kick is enabled.
 *    [- The client is gauranteed to be authorized at this time.
 *
 * @param client        Client index
 * @param auth          Authid response.
 * @param banreason     Banreason if available.
 * @noreturn
 */
forward SmacBans_OnSteamIDBlock(client, const String:auth[], const String:banreason[]);




/**
 * Called before a clients steamid is about to be checked.
 * Note: The client is gauranteed to be authorized at this time.
 *
 * @param client        Client index
 * @param auth          Authid.
 * @return              Plugin_Handled to block the further check, Plugin_Continue otherwise.
 */
forward Action:SmacBans_OnSteamIDCheck(client, const String:auth[]);




/* Do not edit below this line */
public SharedPlugin:__pl_sbblock = 
{
	name = "smacbans-block",
	file = "smacbans-block.smx",
#if defined REQUIRE_PLUGIN
	required = 1,
#else
	required = 0,
#endif
};




#if !defined REQUIRE_PLUGIN
public __pl_sbblock_SetNTVOptional()
{
}
#endif
