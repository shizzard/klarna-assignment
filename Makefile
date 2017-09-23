REBAR := ./rebar3
.PHONY: all compile test dialyze

all: compile test dialyze

compile:
	$(REBAR) compile

test:
	$(REBAR) eunit

dialyze:
	$(REBAR) dialyzer
