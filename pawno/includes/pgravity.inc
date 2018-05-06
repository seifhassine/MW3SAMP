/*
SetPlayerGravity
*/

#if defined _SPG_included
    #endinput
#endif
#define _SPG_included

#if ! defined PAWNRAKNET_INC_
    #error You must have Pawn.RakNet include in order to use this one.
#endif

#if !defined GetGravity
    native Float:GetGravity();
#endif

static Float:SPG_PlayerGravity[MAX_PLAYERS];

/*Functions*/
stock SetPlayerGravity(playerid, Float:gravity)
{
    if(!IsPlayerConnected(playerid)) return 0;

    SPG_PlayerGravity[playerid] = gravity;

    new BitStream:spg_bs = BS_New();

    BS_WriteValue(
        spg_bs,
        PR_FLOAT, gravity
    );

    BS_RPC(spg_bs, playerid, 0x92);
    BS_Delete(spg_bs);
    return 1;
}

stock GetPlayerGravity(playerid, &Float:gravity)
{
    if(!IsPlayerConnected(playerid)) return 0;

    gravity = SPG_PlayerGravity[playerid];
    return 1;
}

/*Callbacks*/
public OnPlayerConnect(playerid)
{
    SPG_PlayerGravity[playerid] = GetGravity();
    #if defined SPG_OnPlayerConnect
        return SPG_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

public OnOutcomingRPC(playerid, rpcid, BitStream:bs)
{
    if(rpcid == 0x92)
    {
        BS_ReadValue(bs, PR_FLOAT, SPG_PlayerGravity[playerid]);
        BS_ResetReadPointer(bs);
    }
    #if defined SPG_OnOutcomingRPC
        return SPG_OnOutcomingRPC(playerid, rpcid, bs);
    #else
        return 1;
    #endif
}

/*Hooks*/
#if defined _ALS_OnOutcomingRPC
#undef OnOutcomingRPC
#else
#define _ALS_OnOutcomingRPC
#endif
#define OnOutcomingRPC SPG_OnOutcomingRPC

#if defined SPG_OnOutcomingRPC
forward SPG_OnOutcomingRPC(playerid, rpcid, BitStream:bs);
#endif

#if defined _ALS_OnPlayerConnect
#undef OnPlayerConnect
#else
#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect SPG_OnPlayerConnect

#if defined SPG_OnPlayerConnect
forward SPG_OnPlayerConnect(playerid);
#endif
