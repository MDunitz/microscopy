.PHONY: fmt
fmt:
	black scripts tests
	flake8 scripts tests

.PHONY: unit-test
unit-test:
	python3 -m unittest discover --start-directory tests/unit --top-level-directory . --verbose

.PHONY: install-reqs
install-reqs:
	pip install -r requirements.txt

.PHONY: init
init: clean
	python3 -m venv .env
	pwd
	ls -la
	. .env/bin/activate
	make install-reqs
	@if [ "$(vscode)" = "True" ]; then\
	    ipython kernel install --user --name=$(project);\
	fi

.PHONY: clean
clean:
	echo "Clearing figures folder"
	rm -rf figures
	mkdir figures
	rm -rf .env

help: ## display help for this makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 
'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: print-home
print-home:
	for i in `ls $(dr)`; do\
		lp -d Brother_HL_L2350DW_series $(dr)/$$i  -o sides=two-sided-long-edge;\
	done

.PHONY: print-school
print-school:
	for i in `ls $(dr)`; do\
		lp -d _131_215_67_136 $(dr)/$$i  -P 1-2 -o sides=two-sided-long-edge;\
	done



	