/*
	Anti Troll System by Jelly23
*/


/*
	Usage: Add OnPlayerTroll(playerid) callback in the gamemode
*/

/*Variables*/
static
	ATV_Timer,
	ATV_Tempo[MAX_PLAYERS],
	ATV_Carro[MAX_PLAYERS],
	ATV_RJack[MAX_PLAYERS],
	ATV_UPTICK[MAX_PLAYERS];

forward ATV_TrollCheck();
forward OnPlayerTroll(playerid);

public OnGameModeInit()
{
	ATV_Timer = SetTimer("ATV_TrollCheck", 1000, true);
	#if defined JT_OnGameModeInit
	return JT_OnGameModeInit();
	#else
	return 1;
	#endif
}

public OnGameModeExit()
{
	KillTimer(ATV_Timer);
	#if defined JT_OnGameModeExit
	return JT_OnGameModeExit();
	#else
	return 1;
	#endif
}

public ATV_TrollCheck()
{
	foreach(new i: Player)
	{
		if(IsPlayerInAnyVehicle(i))
		{
			if(GetPlayerVehicleID(i) != ATV_Carro[i] && ATV_UPTICK[i] > gettime())
			{
				if(gettime() > ATV_Tempo[i])
				{
					OnPlayerTroll(i);
				}
			}
			new Float:X, Float:Y, Float:Z;
			GetVehicleVelocity(GetPlayerVehicleID(i), X, Y, Z);
			if(floatround(floatsqroot(X * X + Y * Y) * 200, floatround_round) > 300)
			{
				OnPlayerTroll(i);
			}
		}
	}
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(ATV_RJack[playerid])
		{
			OnPlayerTroll(playerid);
		}
		if(oldstate == PLAYER_STATE_PASSENGER)
		{
			OnPlayerTroll(playerid);
		}
	}

	#if defined JT_OnPlayerStateChange
	return JT_OnPlayerStateChange(playerid, newstate, oldstate);
	#else
	return 1;
	#endif
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	ATV_Carro[playerid] = vehicleid;
	if(!ispassenger)
	{
		ATV_RJack[playerid] = 1;
	}
	#if defined JT_OnPlayerEnterVehicle
	return JT_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
	#else
	return 1;
	#endif
}

public OnPlayerUpdate(playerid)
{
	ATV_UPTICK[playerid] = gettime()+2;
	if(ATV_RJack[playerid] == 1 && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_ENTER_VEHICLE)
	{
		ATV_RJack[playerid] = 0;
		ATV_Tempo[playerid] = gettime()+3;
	}
	#if defined JT_OnPlayerUpdate
	return JT_OnPlayerUpdate(playerid);
	#else
	return 1;
	#endif
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
    if(floatround(floatsqroot(vel_x * vel_x + vel_y * vel_y) * 200, floatround_round) > 1100)
	{
		OnPlayerTroll(playerid);
		return 0;
	}
	if(GetVehicleDistanceFromPoint(vehicleid, new_x, new_y, new_z) > 0.4)
	{
		return 0;
	}
	#if defined JT_OnUnoccupiedVehicleUpdate
	return JT_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z);
	#else
	return 1;
	#endif
}

#if defined _ALS_OnPlayerStateChange
#undef OnPlayerStateChange
#else
#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange     JT_OnPlayerStateChange

#if defined JT_OnPlayerStateChange
forward JT_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

#if defined _ALS_OnPlayerEnterVehicle
#undef OnPlayerEnterVehicle
#else
#define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle     JT_OnPlayerEnterVehicle

#if defined JT_OnPlayerEnterVehicle
forward JT_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
#endif

#if defined _ALS_OnPlayerUpdate
#undef OnPlayerUpdate
#else
#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate     JT_OnPlayerUpdate

#if defined JT_OnPlayerUpdate
forward JT_OnPlayerUpdate(playerid);
#endif

#if defined _ALS_OnUnoccupiedVehicleUpdate
#undef OnUnoccupiedVehicleUpdate
#else
#define _ALS_OnUnoccupiedVehicleUpdate
#endif
#define OnUnoccupiedVehicleUpdate     JT_OnUnoccupiedVehicleUpdate

#if defined JT_OnUnoccupiedVehicleUpdate
forward JT_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z);
#endif

#if defined _ALS_OnGameModeInit
#undef OnGameModeInit
#else
#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit     JT_OnGameModeInit

#if defined JT_OnGameModeInit
forward JT_OnGameModeInit();
#endif

#if defined _ALS_OnGameModeExit
#undef OnGameModeExit
#else
#define _ALS_OnGameModeExit
#endif
#define OnGameModeExit     JT_OnGameModeExit

#if defined JT_OnGameModeExit
forward JT_OnGameModeExit();
#endif

stock JT_PutPlayerInVehicle(playerid, vehicleid, seatid)
{
	ATV_Tempo[playerid] = gettime()+3;
	ATV_Carro[playerid] = vehicleid;
	ATV_RJack[playerid] = 0;
	return PutPlayerInVehicle(playerid, vehicleid, seatid);
}

stock JT_RemovePlayerFromVehicle(playerid)
{
	ATV_Tempo[playerid] = gettime()+6;
	ATV_Carro[playerid] = 0;
	ATV_RJack[playerid] = 0;
	return RemovePlayerFromVehicle(playerid);
}

#if defined _ALS_RemovePlayerFromVehicle
#undef RemovePlayerFromVehicle
#else
#define _ALS_RemovePlayerFromVehicle
#endif

#define RemovePlayerFromVehicle JT_RemovePlayerFromVehicle

#if defined _ALS_PutPlayerInVehicle
#undef PutPlayerInVehicle
#else
#define _ALS_PutPlayerInVehicle
#endif

#define PutPlayerInVehicle JT_PutPlayerInVehicle
