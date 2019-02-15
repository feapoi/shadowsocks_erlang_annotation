%%%-------------------------------------------------------------------
%%% @author Thoe
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. 二月 2019 12:22
%%%-------------------------------------------------------------------
-module(start).
-author("Thoe").

%% API
-export([start/0]).
start() ->
    application:start(mnesia),
    application:start(mysql),
    application:start(poolboy),
    application:start(mysql_poolboy),
    application:start(sserl).