%% coding: UTF-8\n

-module(runner).

-export([
		  run/0
		]).

run() ->
	Codes = [
	         "Z🤣🤣😀😃😄😁😆😂😅🐜+K😑[&^😐¯P😍÷I😍×E😍😍😍😍 ← 1 2 3"
%	         "Z😍 ← 1 2 3"
%			 "KORYTNAČKA ← 1 2 3"
	         ],
	[run(X) || X <- Codes],
	exit(1).

run(Code) ->
	  io:format("~nCode is ~p~n~n", [Code]),
    Tokens  = pometo_lexer:get_tokens(Code),
	  io:format("Tokens is ~p~n", [Tokens]),
    {Parsed, _Bindings}  = parse(Tokens),
	  io:format("Parsed is ~p~n", [Parsed]),
    Results = pometo_runtime:run_ast(Parsed),
	  io:format("Results is ~p~n", [Results]),
    FormattedResults = lists:flatten(pometo_runtime:format(Results)),
    io:format("~nFormatted results is ~p~n~n", [FormattedResults]),
    {module, _} = pometo_compiler:compile(Parsed),
    X = pometo:run(),
    io:format("X is ~p~n", [X]).

noodle() ->	make_module(bingo).

make_module(Name) ->
	Mod0 = lfe_gen:new_module(Name),
    Mod1 = lfe_gen:add_exports([[run, 0]], Mod0),
    %Mod2 = make_funcs(Params, Mod1),
%    Mod2 = lfe_gen:add_form([defun,run,[],
%           [':',pometo_runtime,monadic,
%            [list,"+",
%             [tuple,
%              [quote,liffey],
%              [tuple,[quote,'¯¯\x{2374}¯¯'],[quote,eager],[quote,false],[4]],
%              [list, 0,1,2,-1]]]]], Mod1),

    Mod2 = lfe_gen:add_form([defun, run, [], ['let', [['x🤣😀😃😄😁😆😂😅🐜😑😐😍', [list, 1, -2, 3]]], 'x🤣😀😃😄😁😆😂😅🐜😑😐😍']], Mod1),
    Forms = lfe_gen:build_mod(Mod2),
    io:format("Forms is ~p~n", [Forms]),
    {ok, Name, Binary, _} = lfe_gen:compile_mod(Mod2),
    {module, Name} = code:load_binary(Name, "nofile", Binary),
    bingo:run().

parse(Tokenlist) ->
    Parsed = pometo_parser:parse(Tokenlist),
    case Parsed of
        {ok,    Parse} -> Parse;
        {error, Error} -> io:format("Parser error ~p~n", [Error]),
                          "error"
    end.