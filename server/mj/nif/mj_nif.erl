-module(mj_nif).

-define(INT8, 8/signed-integer-little).

-define(UINT8, 8/unsigned-integer-little).



-define(INT16, 16/signed-integer-little).

-define(UINT16, 16/unsigned-integer-little).



-define(INT32, 32/signed-integer-little).

-define(UINT32, 32/unsigned-integer-little).



-define(INT64, 64/signed-integer-little).

-define(UINT64, 64/unsigned-integer-little).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-define(BIG_INT8, 8/signed-integer-big).

-define(BIG_UINT8, 8/unsigned-integer-big).



-define(BIG_INT16, 16/signed-integer-big).

-define(BIG_UINT16, 16/unsigned-integer-big).



-define(BIG_INT32, 32/signed-integer-big).

-define(BIG_UINT32, 32/unsigned-integer-big).



-define(BIG_INT64, 64/signed-integer-big).

-define(BIG_UINT64, 64/unsigned-integer-big).

-export([init/0]).
-export([game_start/3, game_oper/2]).
-export([resolve/1]).
init() ->
	erlang:load_nif("./mj_nif", 0).

-define(HH_POOL_COUNT, 120).


game_start(GameType, BankerNumber, RandSeed) when is_integer(GameType) andalso is_integer(BankerNumber) andalso is_integer(RandSeed) ->
	exception.

resolve(Bin) ->
	<<
		PaiPool:120/binary, PoolHeadReadIndex:?BIG_UINT8, PoolTailReadIndex:?BIG_UINT8,
		Seat0:28/binary, Seat1:28/binary,Seat2:28/binary,Seat3:28/binary,
		BrankerNumber:?BIG_UINT8, CurrentSeatNumber:?BIG_UINT8, LastTime:?BIG_UINT32
	>> = Bin,
	io:format("raw_pool=~p~n", [binary_to_list(PaiPool)]),
	io:format("pool_head_read_index=~p~n", [PoolHeadReadIndex]),
	io:format("pool_tail_read_index=~p~n", [PoolTailReadIndex]),
	HeadLen = PoolTailReadIndex,
	TailLen = ?HH_POOL_COUNT - 1 - PoolTailReadIndex,
	ValidPoolLen = ?HH_POOL_COUNT - HeadLen - TailLen,
	io:format("head_len=~p, valid_pool_len=~p, tail_len=~p~n", [HeadLen, ValidPoolLen, TailLen]),
	<<_:HeadLen/binary, ValidPool:ValidPoolLen/binary, _:TailLen/binary>> = PaiPool,
	ValidPoolList = binary_to_list(ValidPool),
	io:format("vaild_pool_list=~p~n", [ValidPoolList]),


	ok.
%%resolve(Bin) ->
%%	<<
%%		P1:?BIG_UINT8, P2:?BIG_UINT8,P3:?BIG_UINT8, P4:?BIG_UINT8, P5:?BIG_UINT8, P6:?BIG_UINT8, P7:?BIG_UINT8, P8:?BIG_UINT8, P9:?BIG_UINT8, P10:?BIG_UINT8,
%%		P11:?BIG_UINT8, P12:?BIG_UINT8,P13:?BIG_UINT8, P14:?BIG_UINT8, P15:?BIG_UINT8, P16:?BIG_UINT8, P17:?BIG_UINT8, P18:?BIG_UINT8, P19:?BIG_UINT8, P20:?BIG_UINT8,
%%		P21:?BIG_UINT8, P22:?BIG_UINT8,P23:?BIG_UINT8, P24:?BIG_UINT8, P25:?BIG_UINT8, P26:?BIG_UINT8, P27:?BIG_UINT8, P28:?BIG_UINT8, P29:?BIG_UINT8, P30:?BIG_UINT8,
%%		P31:?BIG_UINT8, P32:?BIG_UINT8,P33:?BIG_UINT8, P34:?BIG_UINT8, P35:?BIG_UINT8, P36:?BIG_UINT8, P37:?BIG_UINT8, P38:?BIG_UINT8, P39:?BIG_UINT8, P40:?BIG_UINT8,
%%		P41:?BIG_UINT8, P42:?BIG_UINT8,P43:?BIG_UINT8, P44:?BIG_UINT8, P45:?BIG_UINT8, P46:?BIG_UINT8, P47:?BIG_UINT8, P48:?BIG_UINT8, P49:?BIG_UINT8, P50:?BIG_UINT8,
%%		P51:?BIG_UINT8, P52:?BIG_UINT8,P53:?BIG_UINT8, P54:?BIG_UINT8, P55:?BIG_UINT8, P56:?BIG_UINT8, P57:?BIG_UINT8, P58:?BIG_UINT8, P59:?BIG_UINT8, P60:?BIG_UINT8,
%%		P61:?BIG_UINT8, P62:?BIG_UINT8,P63:?BIG_UINT8, P64:?BIG_UINT8, P65:?BIG_UINT8, P66:?BIG_UINT8, P67:?BIG_UINT8, P68:?BIG_UINT8, P69:?BIG_UINT8, P70:?BIG_UINT8,
%%		P71:?BIG_UINT8, P72:?BIG_UINT8,P73:?BIG_UINT8, P74:?BIG_UINT8, P75:?BIG_UINT8, P76:?BIG_UINT8, P77:?BIG_UINT8, P78:?BIG_UINT8, P79:?BIG_UINT8, P80:?BIG_UINT8,
%%		P81:?BIG_UINT8, P82:?BIG_UINT8,P83:?BIG_UINT8, P84:?BIG_UINT8, P85:?BIG_UINT8, P86:?BIG_UINT8, P87:?BIG_UINT8, P88:?BIG_UINT8, P89:?BIG_UINT8, P90:?BIG_UINT8,
%%		P91:?BIG_UINT8, P92:?BIG_UINT8,P93:?BIG_UINT8, P94:?BIG_UINT8, P95:?BIG_UINT8, P96:?BIG_UINT8, P97:?BIG_UINT8, P98:?BIG_UINT8, P99:?BIG_UINT8, P100:?BIG_UINT8,
%%		P101:?BIG_UINT8, P102:?BIG_UINT8,P103:?BIG_UINT8, P104:?BIG_UINT8, P105:?BIG_UINT8, P106:?BIG_UINT8, P107:?BIG_UINT8, P108:?BIG_UINT8, P109:?BIG_UINT8, P110:?BIG_UINT8,
%%		P111:?BIG_UINT8, P112:?BIG_UINT8,P113:?BIG_UINT8, P114:?BIG_UINT8, P115:?BIG_UINT8, P116:?BIG_UINT8, P117:?BIG_UINT8, P118:?BIG_UINT8, P119:?BIG_UINT8, P120:?BIG_UINT8,
%%
%%		PoolHeadReadIndex:?BIG_UINT8, PoolTailReadIndex:?BIG_UINT8,
%%
%%		S0C1:?BIG_UINT8, S0C2:?BIG_UINT8,S0C3:?BIG_UINT8, S0C4:?BIG_UINT8,
%%		S0P1:?BIG_UINT8, S0P2:?BIG_UINT8,S0P3:?BIG_UINT8, S0P4:?BIG_UINT8,
%%		S0G1:?BIG_UINT8, S0G2:?BIG_UINT8,S0G3:?BIG_UINT8, S0G4:?BIG_UINT8,
%%		S0Pai1:?BIG_UINT8, S0Pai2:?BIG_UINT8,S0Pai3:?BIG_UINT8, S0Pai4:?BIG_UINT8,S0Pai5:?BIG_UINT8, S0Pai6:?BIG_UINT8,S0Pai7:?BIG_UINT8,
%%		S0Pai8:?BIG_UINT8, S0Pai9:?BIG_UINT8,S0Pai10:?BIG_UINT8, S0Pai11:?BIG_UINT8,S0Pai12:?BIG_UINT8, S0Pai13:?BIG_UINT8,S0Pai14:?BIG_UINT8,
%%		S0WriteIndex:?BIG_UINT8, S0OperFlag:?BIG_UINT8,
%%
%%
%%		S1C1:?BIG_UINT8, S1C2:?BIG_UINT8,S1C3:?BIG_UINT8, S1C4:?BIG_UINT8,
%%		S1P1:?BIG_UINT8, S1P2:?BIG_UINT8,S1P3:?BIG_UINT8, S1P4:?BIG_UINT8,
%%		S1G1:?BIG_UINT8, S1G2:?BIG_UINT8,S1G3:?BIG_UINT8, S1G4:?BIG_UINT8,
%%		S1Pai1:?BIG_UINT8, S1Pai2:?BIG_UINT8,S1Pai3:?BIG_UINT8, S1Pai4:?BIG_UINT8,S1Pai5:?BIG_UINT8, S1Pai6:?BIG_UINT8,S1Pai7:?BIG_UINT8,
%%		S1Pai8:?BIG_UINT8, S1Pai9:?BIG_UINT8,S1Pai10:?BIG_UINT8, S1Pai11:?BIG_UINT8,S1Pai12:?BIG_UINT8, S1Pai13:?BIG_UINT8,S1Pai14:?BIG_UINT8,
%%		S1WriteIndex:?BIG_UINT8, S1OperFlag:?BIG_UINT8,
%%
%%
%%		S2C1:?BIG_UINT8, S2C2:?BIG_UINT8,S2C3:?BIG_UINT8, S2C4:?BIG_UINT8,
%%		S2P1:?BIG_UINT8, S2P2:?BIG_UINT8,S2P3:?BIG_UINT8, S2P4:?BIG_UINT8,
%%		S2G1:?BIG_UINT8, S2G2:?BIG_UINT8,S2G3:?BIG_UINT8, S2G4:?BIG_UINT8,
%%		S2Pai1:?BIG_UINT8, S2Pai2:?BIG_UINT8,S2Pai3:?BIG_UINT8, S2Pai4:?BIG_UINT8,S2Pai5:?BIG_UINT8, S2Pai6:?BIG_UINT8,S2Pai7:?BIG_UINT8,
%%		S2Pai8:?BIG_UINT8, S2Pai9:?BIG_UINT8,S2Pai10:?BIG_UINT8, S2Pai11:?BIG_UINT8,S2Pai12:?BIG_UINT8, S2Pai13:?BIG_UINT8,S2Pai14:?BIG_UINT8,
%%		S2WriteIndex:?BIG_UINT8, S2OperFlag:?BIG_UINT8,
%%
%%
%%		S3C1:?BIG_UINT8, S3C2:?BIG_UINT8,S3C3:?BIG_UINT8, S3C4:?BIG_UINT8,
%%		S3P1:?BIG_UINT8, S3P2:?BIG_UINT8,S3P3:?BIG_UINT8, S3P4:?BIG_UINT8,
%%		S3G1:?BIG_UINT8, S3G2:?BIG_UINT8,S3G3:?BIG_UINT8, S3G4:?BIG_UINT8,
%%		S3Pai1:?BIG_UINT8, S3Pai2:?BIG_UINT8,S3Pai3:?BIG_UINT8, S3Pai4:?BIG_UINT8,S3Pai5:?BIG_UINT8, S3Pai6:?BIG_UINT8,S3Pai7:?BIG_UINT8,
%%		S3Pai8:?BIG_UINT8, S3Pai9:?BIG_UINT8,S3Pai10:?BIG_UINT8, S3Pai11:?BIG_UINT8,S3Pai12:?BIG_UINT8, S3Pai13:?BIG_UINT8,S3Pai14:?BIG_UINT8,
%%		S3WriteIndex:?BIG_UINT8, S3OperFlag:?BIG_UINT8,
%%
%%		BrankerSeatNumber:?BIG_UINT8, CurrentSeatNumber:?BIG_UINT8,
%%		LastTime:?BIG_UINT32
%%		>> = Bin,
%%	RawPaiPool = [
%%		P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,
%%		P21,P22,P23,P24,P25,P26,P27,P28,P29,P30,
%%		P31,P32,P33,P34,P35,P36,P37,P38,P39,P40,
%%		P41,P42,P43,P44,P45,P46,P47,P48,P49,P50,
%%		P51,P52,P53,P54,P55,P56,P57,P58,P59,P60,
%%		P61,P62,P63,P64,P65,P66,P67,P68,P69,P70,
%%		P71,P72,P73,P74,P75,P76,P77,P78,P79,P80,
%%		P81,P82,P83,P84,P85,P86,P87,P88,P89,P90,
%%		P91,P92,P93,P94,P95,P96,P97,P98,P99,P100,
%%		P101,P102,P103,P104,P105,P106,P107,P108,P109,P110,
%%		P111,P112,P113,P114,P115,P116,P117,P118,P119,P120],
%%	ValidPaiPool =
%%	ok.


game_oper(V1, V2) ->
	exception.
