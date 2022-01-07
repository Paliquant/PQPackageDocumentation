### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ f30a37ec-6d8c-11ec-1c66-89962478f84e
begin

	# external packages -
	using TOML
	
	# setup paths -
	_PATH_TO_ROOT = pwd()
	_PATH_TO_CONFIG = joinpath(_PATH_TO_ROOT,"config")

	# load the configuration information -
	# alias the Polygon.io URL -
    DATASTORE_URL_STRING = "https://api.polygon.io"

    # What we have here is the classic good news, bad news situation ...
    # Bad news: We don't check in our Polygon.io API key to GitHub (sorry). 
    # Good news: Polygon.io API keys are free. check out: https://polygon.io -
    configuration_dictionary = TOML.parsefile(joinpath(_PATH_TO_CONFIG, "Configuration.toml"))

    # get some stuff from the configuration dictionary -
    POLYGON_API_KEY = configuration_dictionary["API"]["polygon_api_key"]
	
	# load the PQPolygonSDK.jl package -
	import Pkg
	Pkg.add(url="https://github.com/Paliquant/PQPolygonSDK.jl")
end

# ╔═╡ f30a37b0-6d8c-11ec-29c7-c94ace581f52
html"""
	<div>Happy holiday! Remember to take care of yourself and your loved ones!</div>
<div id="snow"></div>
<style>
	body:not(.disable_ui):not(.more-specificity) {
        background-color:#e9ecff;
    }
	pluto-output{
		border-radius: 0px 8px 0px 0px;
        background-color:#e9ecff;
	}
	#snow {
        position: fixed;
    	top: 0;
    	left: 0;
    	right: 0;
    	bottom: 0;
    	pointer-events: none;
    	z-index: 1000;
	}
</style>
<script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
<script>
        setTimeout(() => window.particlesJS("snow", {
            "particles": {
                "number": {
                    "value": 70,
                    "density": {
                        "enable": true,
                        "value_area": 800
                    }
                },
                "color": {
                    "value": "#ffffff"
                },
                "opacity": {
                    "value": 0.7,
                    "random": false,
                    "anim": {
                        "enable": false
                    }
                },
                "size": {
                    "value": 5,
                    "random": true,
                    "anim": {
                        "enable": false
                    }
                },
                "line_linked": {
                    "enable": false
                },
                "move": {
                    "enable": true,
                    "speed": 5,
                    "direction": "bottom",
                    "random": true,
                    "straight": false,
                    "out_mode": "out",
                    "bounce": false,
                    "attract": {
                        "enable": true,
                        "rotateX": 300,
                        "rotateY": 1200
                    }
                }
            },
            "interactivity": {
                "events": {
                    "onhover": {
                        "enable": false
                    },
                    "onclick": {
                        "enable": false
                    },
                    "resize": false
                }
            },
            "retina_detect": true
        }), 3000);
	</script>
"""


# ╔═╡ b0aa81e5-adcd-401e-bce8-ee63960378ce
md"""
## PQPolygonSDK.jl

Data is the key to making great financial decisions. [Polygon.io](https://polygon.io) is a financial data warehouse that provides an application programming interface (API) that can be used to download and analyze all kinds of financial information. The `PQPolygonSDK.jl` package is a software development kit (SDK) written in the Julia programing language for the [Polygon.io](https://polygon.io) system.

[Polygon.io](https://polygon.io) was founded by former Googlers in 2016. Since September of 2020, [Polygon.io](https://polygon.io) has provided both [free and paid access](https://polygon.io/pricing) to current and historical [stock](https://polygon.io/docs/stocks/getting-started), [option](https://polygon.io/docs/options/getting-started), [crypto](https://polygon.io/docs/crypto/getting-started) and [forex](https://polygon.io/docs/forex/getting-started) data.  
Check out the [Polygon.io blog](https://polygon.io/blog/) for the latest updates and developments from [Polygon.io](https://polygon.io).

In this notebook, we'll discuss how to the `PQPolygonSDK.jl` package with the [Polygon.io REST API](https://polygon.io/docs/stocks). In particular, we'll:

* Download and analyze daily stock price data for an arbitrary ticker symbol and a specified date range
* Download and analyze crypto data for an arbitrary ticker and a specified date range
* Download and analyze option data for an arbitrary ticker and a specified date range
"""

# ╔═╡ 95e08b94-ba07-47e5-8982-8719d1af8877
html"""
<style>
main {
    max-width: 1200px;
    width: 85%;
    margin: auto;
    font-family: "Roboto, monospace";
}

a {
    color: blue;
    text-decoration: none;
}

.H1 {
    padding: 0px 30px;
}
</style>"""

# ╔═╡ Cell order:
# ╟─f30a37b0-6d8c-11ec-29c7-c94ace581f52
# ╠═f30a37ec-6d8c-11ec-1c66-89962478f84e
# ╠═b0aa81e5-adcd-401e-bce8-ee63960378ce
# ╟─95e08b94-ba07-47e5-8982-8719d1af8877
