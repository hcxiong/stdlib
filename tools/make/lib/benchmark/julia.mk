
# TARGETS #

#/
# Runs Julia benchmarks consecutively.
#
# ## Notes
#
# -   This recipe assumes that benchmark files can be run via Julia.
# -   This recipe is useful when wanting to glob for Julia benchmark files (e.g., run all Julia benchmarks for a particular package).
#
#
# @param {string} [BENCHMARKS_FILTER] - filepath pattern (e.g., `.*/math/base/special/erf/.*`)
#
# @example
# make benchmark-julia
#
# @example
# make benchmark-julia BENCHMARKS_FILTER=.*/math/base/special/erf/.*
#/
benchmark-julia:
	$(QUIET) $(FIND_JULIA_BENCHMARKS_CMD) | grep '^[\/]\|^[a-zA-Z]:[/\]' | while read -r file; do \
		echo ""; \
		echo "Running benchmark: $$file"; \
		$(MAKE_EXECUTABLE) $$file && $$file || exit 1; \
	done

.PHONY: benchmark-julia

#/
# Runs a specified list of Julia benchmarks consecutively.
#
# ## Notes
#
# -   This recipe assumes that benchmark files can be run via Julia.
# -   This recipe is useful when wanting to run a list of Julia benchmark files generated by some other command (e.g., a list of changed Julia benchmark files obtained via `git diff`).
#
#
# @param {string} FILES - list of Julia benchmark file paths
#
# @example
# make benchmark-julia-files FILES='/foo/benchmark.jl /bar/benchmark.jl'
#/
benchmark-julia-files:
	$(QUIET) for file in $(FILES); do \
		echo ""; \
		echo "Running benchmark: $$file"; \
		$(MAKE_EXECUTABLE) $$file && $$file || exit 1; \
	done

.PHONY: benchmark-julia-files
