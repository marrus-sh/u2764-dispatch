MARKET_COMMONS := ./MarketCommons/MarketCommons

sources := $(wildcard docs/Sources/*.market)
targets := $(patsubst docs/Sources/%.market,%,$(sources))
results := $(patsubst docs/Sources/%.market,docs/%.xhtml,$(sources))

all: $(targets) ;
$(targets): %: docs/%.xhtml ;
$(results): docs/%.xhtml: docs/Sources/%.market HEAD.xml
	(FIRST=$$(head -c1 $<); if [ $$FIRST == "<" ]; then cat HEAD.xml | tr -d '﻿' | tr -s '\n'; else (cat HEAD.xml | tr -d '﻿' | tr -s '\n'; echo; echo); fi; cat $<) | $(MARKET_COMMONS) - $@
# The BOM (U+FEFF) can be used to trail lines of intentional whitespace in HEAD.xml to keep them from being trimmed (by editors) and then squashed.

.PHONY: $(targets) all
