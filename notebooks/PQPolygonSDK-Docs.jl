### A Pluto.jl notebook ###
# v0.17.5

using Markdown
using InteractiveUtils

# ╔═╡ f30a37ec-6d8c-11ec-1c66-89962478f84e
begin

	# load required external packages -
	using PlutoUI
	using TOML
	using Dates
	using PQPolygonSDK
	
	# show -
	nothing
end

# ╔═╡ ee95e493-b7a6-43df-88c0-88ecf5028843
md"""
# PQPolygonSDK.jl
"""

# ╔═╡ b0aa81e5-adcd-401e-bce8-ee63960378ce
md"""
### Introduction

Data is the key to making great decisions, and this is especially true in the finance world. [Polygon.io](https://polygon.io) is a financial data warehouse that has an application programming interface (API) which you can use to access all kinds of financial data and other information. The `PQPolygonSDK.jl` package is a software development kit (SDK) written in the [Julia programing language](https://julialang.org) for the [Polygon.io](https://polygon.io) application programming interface.

[Polygon.io](https://polygon.io) was founded by former Googlers in 2016. Since September of 2020, [Polygon.io](https://polygon.io) has provided both [free and paid access](https://polygon.io/pricing) to current and historical [stock](https://polygon.io/docs/stocks/getting-started), [option](https://polygon.io/docs/options/getting-started), [crypto](https://polygon.io/docs/crypto/getting-started) and [forex](https://polygon.io/docs/forex/getting-started) data.  
Check out the [Polygon.io blog](https://polygon.io/blog/) for the latest updates and developments from [Polygon.io](https://polygon.io).

In this notebook, we'll discuss how to use the `PQPolygonSDK.jl` package to query the [Polygon.io REST API](https://polygon.io/docs/stocks). In particular, we'll:

* Download and analyze daily stock price data for an arbitrary ticker symbol and a specified date range
* Download and analyze crypto data for an arbitrary ticker and a specified date range
* Download information about a stock ticker e.g., Apple (AAPL) and Microsoft (MSFT)
"""

# ╔═╡ fdc9fa10-4ac0-4055-ae8a-db3f16f2ae36


# ╔═╡ 66c5e100-ce9c-4387-a662-cd93cf76718b


# ╔═╡ 672868d2-c09a-4230-8d90-a09d7af7ae8d


# ╔═╡ dbd1eead-5e9f-4861-90a5-badcb5b2ad57


# ╔═╡ 2c357a88-e6da-420f-bb50-0a7bcd824de3
md"""
##### Installation and Requirements

`PQPolygonSDK.jl` can be installed, updated, or removed using the [Julia package management system](https://docs.julialang.org/en/v1/stdlib/Pkg/). To access the package management interface, open the [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/), and start the package mode by pressing `]`.
While in package mode, to install `PQPolygonSDK.jl`, issue the command:

```julia       
(@v1.7.x) pkg> add PQPolygonSDK
```

Once installed, to use `PQPolygonSDK.jl` in your projects (like a Pluto notebook), issue the command:

```julia
julia> using PQPolygonSDK
```
"""

# ╔═╡ f87b1e0a-e6bb-4931-a590-15c2f2865572


# ╔═╡ 106d8bd6-beaf-4552-8a1c-e0536137ad43


# ╔═╡ 7fcd9ada-dd7c-4a02-9f12-b998ea9df3ad


# ╔═╡ 9c38031a-7a57-45ce-baa7-c13df489a3d8


# ╔═╡ 44891bab-deb2-4c55-8257-9d9ede10761c
md"""
### Overview of a Polygon API call using the PQPolygonSDK package

There are four steps required to make a Polygon.io API call using the `PQPolygonSDK.jl` package:

1. Create a `PQPolygonSDKUserModel` object
1. Create an instance of an `AbstractPolygonEndpointModel` object
1. Use the user and endpoint models to build the actual URL string
1. Call the API and get data back.

##### Build a user model
All [Polygon.io](https://polygon.io) application programming interface (API) calls in the `PQPolygonSDK.jl` package are started by creating a `PQPolygonSDKUserModel` object using the function:


```julia    
model(userModelType::Type{PQPolygonSDKUserModel}, 
    options::Dict{String,Any}) -> PQPolygonSDKUserModel
```
    
where the `options` dictionary holds `email` and `apikey` key-value pairs. 

##### Build an endpoint model
The `PQPolygonSDKUserModel` object can then be passed as an argument to a `model` function:

```julia
model(apiModelType::Type{T}, userModel::PQPolygonSDKUserModel, 
        options::Dict{String,Any}) -> AbstractPolygonEndpointModel where T<:AbstractPolygonEndpointModel
```

to build an endpoint-specific model where the information for a particular endpoint is passed into the `model` method via an `options` dictionary.

##### Encode the URL string 
The endpoint specific model is then used to create the specific URL for the call using the `url` function: 

```julia
# create the URL string for this endpoint -
my_stock_url_string = url(POLYGON_URL_STRING, stock_endpoint_model);
```

##### Make the API call
Finally, the URL and type of API model type are used to make the API call:

```julia
# make the API call -
(h_stock, df_stock) = api(PolygonAggregatesEndpointModel, my_stock_url_string);
```

The `api` method returns two pieces of data, a header dictionary holding technical information about the call (and potentially error information of the call failed). The data for the call is returned as a [DataFrame](https://dataframes.juliadata.org/stable/). 

"""

# ╔═╡ 40db3a68-cd4e-45df-89a0-f9f1eb8d7227


# ╔═╡ 96fde2cf-c457-4f40-a8d3-1351a02abf49


# ╔═╡ f5398c1d-4f6f-4d10-8410-0ed9db82ae74


# ╔═╡ f650a3ae-56a3-4807-8e99-2a7d1693bff0


# ╔═╡ 8ff5ac28-b6e6-42e4-b99d-2f26cda1e9be
md"""
### Aggregates Endpoint: Download Stock, Cryptocurreny and Forex Price Data

[The Aggregates endpoint on Polygon.io](https://polygon.io/docs/stocks/get_v2_aggs_ticker__stocksticker__range__multiplier___timespan___from___to) can be used to access the Open/High/Low/Close (OHLC) price (along with other data like volume, and volume-weighted average price or vwap) at different time resolutions ranging from minutes to yearly for stocks, options, cryptocurrencies and foreign exchange (forex). In this section, let's look at examples for stocks, cryptocurrencies, and forex. We'll save options for a later time.

In each of these cases, a `PolygonAggregatesEndpointModel` is constructed using the `model` function:

```julia
model(apiModelType::Type{T}, userModel::PQPolygonSDKUserModel, 
        options::Dict{String,Any}) -> AbstractPolygonEndpointModel 
			where T<:AbstractPolygonEndpointModel
```

where the `options` dictionary holds the data for the API call as `key => value` pairs. See the [Aggregates endpoint documentation](https://polygon.io/docs/stocks/get_v2_aggs_ticker__stocksticker__range__multiplier___timespan___from___to) for the data that must be included.  Lastly, we use the `PolygonAggregatesEndpointModel` for stocks, crypto, forex, and options, where the ticker symbol convention for each type of asset is the only difference.  

"""

# ╔═╡ 80f33d55-bfaf-4558-a638-6613b448d6ee


# ╔═╡ 9c54bf05-9641-4505-8fbc-00d4a7ac468f


# ╔═╡ 884954ce-1d0d-482a-be99-2748c343a622


# ╔═╡ 30fc61a4-61f6-48aa-b947-65b7d6531a6f


# ╔═╡ 68a6ab3b-6fe2-4551-9d47-2a80d92e4fc6


# ╔═╡ ec916364-67aa-46f3-a656-0b3d44885492


# ╔═╡ 31a69d2b-67cf-4109-8db8-23744e3d0098


# ╔═╡ 041c79b9-d930-4706-a020-8fc2183ef78c
md"""
##### Code to build a user model
"""

# ╔═╡ fe7259dc-6d68-4561-b111-7b8eb62bef25
md"""
##### Download timestamped price data for a ticker symbol and date range

Ticker symbols are unique alphabetical codes that represent a company, e.g., `AAPL` (Apple) or an 
[exchange traded fund (ETF)](https://www.investopedia.com/articles/investing/122215/spy-spdr-sp-500-trust-etf.asp) such as `SPY`,  which tracks the [Standard & Poor's 500 Index](https://www.investopedia.com/terms/s/sp500.asp).

Ticker symbols for stocks e.g., `AAPL` or `MSFT` are relatively easy to find and understand. However, ticker symbols for crypto, forex, and in particular options, are more complicated. For now, let's use the well-known ticker symbols `SPY` to demonstrate [the Aggregates endpoint on Polygon.io](https://polygon.io/docs/stocks/get_v2_aggs_ticker__stocksticker__range__multiplier___timespan___from___to) for a stock. 

However, [Polygon.io](https://polygon.io) has a collection of [reference data endpints](https://polygon.io/docs/stocks/get_v3_reference_tickers) for querying information about ticker symbols that we'll demonstrate below. 
"""

# ╔═╡ dbc25db6-e592-4e7b-82aa-b7ea9dd7f1ee
md"""
##### Download crypto data for an arbitrary cryptocurrency and date range

For cryptocurrencies, the [Polygon.io](https://polygon.io) convention for ticker symbols is `X:<cyrpto>XXX`, where `crypto` denotes the particular cryptocurrency and `XXX` denotes the currency you want to see the price of the cyrpto measured in. 

In the United States, we 
would typcially use United States Dollars `USD`, but in the Eurozone, the measurement currency would be in € or `EUR`. For example, for [bitcoin](https://bitcoin.org/) demarcated United States Dollars (USD), the [Polygon.io](https://polygon.io) ticker is given by: `X:BTCUSD`, while the [bitcoin](https://bitcoin.org/) ticker symbol demarcated in € would be: `X:BTCEUR`.

"""

# ╔═╡ 96166eaa-561b-4ef5-b2d4-f649f0f2dae2
md"""
### Download information about a particular asset ticker symbol
"""

# ╔═╡ 2592fa9a-4194-4206-ac8b-e9727d63b550
TableOfContents(title="📚 Table of Contents", indent=true, depth=5, aside=true)

# ╔═╡ 95e08b94-ba07-47e5-8982-8719d1af8877
html"""
<style>
main {
    max-width: 1200px;
    width: 72%;
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

# ╔═╡ 820238fb-a140-4f38-b58b-745df9b6cf5b
html"""
<script>
	// initialize -
	var section = 0;
	var subsection = 0;
	var headers = document.querySelectorAll('h3, h5');
	
	// main loop -
	for (var i=0; i < headers.length; i++) {
	    
		var header = headers[i];
	    var text = header.innerText;
	    var original = header.getAttribute("text-original");
	    if (original === null) {
	        
			// Save original header text
	        header.setAttribute("text-original", text);
	    } else {
	        
			// Replace with original text before adding section number
	        text = header.getAttribute("text-original");
	    }
	
	    var numbering = "";
	    switch (header.tagName) {
	        case 'H3':
	            section += 1;
	            numbering = section + ".";
	            subsection = 0;
	            break;
	        case 'H5':
	            subsection += 1;
	            numbering = section + "." + subsection;
	            break;
	    }
		// update the header text 
		header.innerText = numbering + " " + text;
	};
</script>"""

# ╔═╡ 5d57883d-c34a-4e5f-9106-b6cad4050a66
begin

	# setup paths -
	_PATH_TO_ROOT = pwd()
	_PATH_TO_CONFIG = joinpath(_PATH_TO_ROOT,"config")

	# load the configuration information -
	# alias the Polygon.io URL -
    POLYGON_URL_STRING = "https://api.polygon.io"

    # What we have here is the classic good news, bad news situation ...
    # Bad news: We don't check in our Polygon.io API key to GitHub (sorry). 
    # Good news: Polygon.io API keys are free. check out: https://polygon.io -
    configuration_dictionary = TOML.parsefile(joinpath(_PATH_TO_CONFIG, "Configuration.toml"))

    # get some stuff from the configuration dictionary -
	# this needs to be YOUR api key, either hardcoded -or- from a config file
    POLYGON_API_KEY = configuration_dictionary["API"]["polygon_api_key"] 
	POLYGON_API_EMAIL = configuration_dictionary["EMAIL"]["email"] 

	# show -
	nothing
end

# ╔═╡ 08a4644d-46b8-48f3-a2ea-30a6474aa966
begin

	# create an options dictionary - holds data about the user (you)
	user_model_options_dict = Dict{String,Any}()
	user_model_options_dict["apikey"] = POLYGON_API_KEY
	user_model_options_dict["email"] = POLYGON_API_EMAIL
	
	# create my user model -
	my_user_model = model(PQPolygonSDKUserModel, user_model_options_dict);

	# show -
	nothing
end

# ╔═╡ e4d1c872-5b50-4f7d-aa2e-044c8aef2040
begin

	# what ticker do we want to download?
	stock_ticker_symbol = "SPY";
	
	# setup the parameters for the call to the endpoint -
	stock_endpoint_options = Dict{String,Any}()
	stock_endpoint_options["adjusted"] = true
	stock_endpoint_options["sortdirection"] = "asc"
	stock_endpoint_options["limit"] = 5000
	stock_endpoint_options["to"] = Date(2021, 12, 24)
	stock_endpoint_options["from"] = Date(2021, 12, 15)
	stock_endpoint_options["multiplier"] = 1
	stock_endpoint_options["timespan"] = "day"
	stock_endpoint_options["ticker"] = stock_ticker_symbol;
	stock_endpoint_model = model(PolygonAggregatesEndpointModel, 
		my_user_model, stock_endpoint_options)

	# create the URL string for this endpoint -
	my_stock_url_string = url(POLYGON_URL_STRING, stock_endpoint_model);

	# make the API call -
	(h_stock, df_stock) = api(PolygonAggregatesEndpointModel, my_stock_url_string);

	# show -
	nothing;
end

# ╔═╡ 516589ec-3f40-4870-9a37-8e030cf1c951
begin

	# what crypto ticker do we want to download?
	crypto_ticker_symbol = "X:BTCUSD";
	
	# setup the parameters for the call to the endpoint -
	crypto_endpoint_options = Dict{String,Any}()
	crypto_endpoint_options["adjusted"] = true
	crypto_endpoint_options["sortdirection"] = "asc"
	crypto_endpoint_options["limit"] = 5000
	crypto_endpoint_options["to"] = Date(2021, 12, 24)
	crypto_endpoint_options["from"] = Date(2021, 12, 15)
	crypto_endpoint_options["multiplier"] = 1
	crypto_endpoint_options["timespan"] = "day"
	crypto_endpoint_options["ticker"] = crypto_ticker_symbol;
	crypto_endpoint_model = model(PolygonAggregatesEndpointModel, 
		my_user_model, crypto_endpoint_options);

	# create the URL string -
	my_crypto_url_string = url(POLYGON_URL_STRING, crypto_endpoint_model);

	# make the API call -
	(h_crypto, df_crypto) = api(PolygonAggregatesEndpointModel, my_crypto_url_string);

	# show -
	nothing;
end

# ╔═╡ 6617f059-c2ad-461e-8e83-73c85441ab5d
h_crypto

# ╔═╡ 9368f7d5-48d2-445c-a55b-2fcc2bf21f8d
df_crypto

# ╔═╡ e0a7bb44-20f7-40b1-9597-a6f0ec1162f0
begin

	# now that we have the user_model, let's build an endpoint model -
	ticker_data_endpoint_options = Dict{String,Any}()
	ticker_data_endpoint_options["ticker"] = "AAPL"
	ticker_data_endpoint_model = model(PolygonTickerDetailsEndpointModel, my_user_model, 
		ticker_data_endpoint_options);

	# build the ticker data url -
	my_ticker_data_url_string = url(POLYGON_URL_STRING, ticker_data_endpoint_model)

	# make the call -
	(h_ticker_data, df_ticker_data) = api(PolygonTickerDetailsEndpointModel, my_ticker_data_url_string)

	# show -
	nothing
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
PQPolygonSDK = "a9381516-e38f-4c81-935c-32707fb4df4c"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
TOML = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[compat]
PQPolygonSDK = "~0.1.3"
PlutoUI = "~0.7.30"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings"]
git-tree-sha1 = "49f14b6c56a2da47608fe30aed711b5882264d7a"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.9.11"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "44c37b4636bc54afac5c574d2d02b625349d6582"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.41.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Crayons]]
git-tree-sha1 = "b618084b49e78985ffa8422f32b9838e397b9fc2"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.0"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "cfdfef912b7f93e4b848e80b9befdf9e331bc05a"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.1"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "04d13bfa8ef11720c24e4d840c0033d145537df7"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.17"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "8d70835a3759cdd75881426fced1508bb7b7e1b6"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.1.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PQPolygonSDK]]
deps = ["CSV", "DataFrames", "Dates", "HTTP", "JSON", "TOML"]
git-tree-sha1 = "f5dfecd13178b9c9a00304f64591a375d1f3ce22"
uuid = "a9381516-e38f-4c81-935c-32707fb4df4c"
version = "0.1.3"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "d7fa6237da8004be601e19bd6666083056649918"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "5c0eb9099596090bb3215260ceca687b888a1575"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.30"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "db3a23166af8aebf4db5ef87ac5b00d36eb771e2"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "244586bc07462d22aed0113af9c731f2a518c93e"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.10"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "bb1064c9a84c52e277f1096cf41434b675cd368b"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.6.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "216b95ea110b5972db65aa90f88d8d89dcb8851c"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.6"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "c69f9da3ff2f4f02e811c3323c22e5dfcb584cfa"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.1"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─ee95e493-b7a6-43df-88c0-88ecf5028843
# ╟─b0aa81e5-adcd-401e-bce8-ee63960378ce
# ╟─fdc9fa10-4ac0-4055-ae8a-db3f16f2ae36
# ╟─66c5e100-ce9c-4387-a662-cd93cf76718b
# ╟─672868d2-c09a-4230-8d90-a09d7af7ae8d
# ╟─dbd1eead-5e9f-4861-90a5-badcb5b2ad57
# ╟─2c357a88-e6da-420f-bb50-0a7bcd824de3
# ╠═f30a37ec-6d8c-11ec-1c66-89962478f84e
# ╟─f87b1e0a-e6bb-4931-a590-15c2f2865572
# ╟─106d8bd6-beaf-4552-8a1c-e0536137ad43
# ╟─7fcd9ada-dd7c-4a02-9f12-b998ea9df3ad
# ╟─9c38031a-7a57-45ce-baa7-c13df489a3d8
# ╟─44891bab-deb2-4c55-8257-9d9ede10761c
# ╟─40db3a68-cd4e-45df-89a0-f9f1eb8d7227
# ╟─96fde2cf-c457-4f40-a8d3-1351a02abf49
# ╟─f5398c1d-4f6f-4d10-8410-0ed9db82ae74
# ╟─f650a3ae-56a3-4807-8e99-2a7d1693bff0
# ╟─8ff5ac28-b6e6-42e4-b99d-2f26cda1e9be
# ╟─80f33d55-bfaf-4558-a638-6613b448d6ee
# ╟─9c54bf05-9641-4505-8fbc-00d4a7ac468f
# ╟─884954ce-1d0d-482a-be99-2748c343a622
# ╟─30fc61a4-61f6-48aa-b947-65b7d6531a6f
# ╟─68a6ab3b-6fe2-4551-9d47-2a80d92e4fc6
# ╟─ec916364-67aa-46f3-a656-0b3d44885492
# ╟─31a69d2b-67cf-4109-8db8-23744e3d0098
# ╟─041c79b9-d930-4706-a020-8fc2183ef78c
# ╠═08a4644d-46b8-48f3-a2ea-30a6474aa966
# ╟─fe7259dc-6d68-4561-b111-7b8eb62bef25
# ╠═e4d1c872-5b50-4f7d-aa2e-044c8aef2040
# ╟─dbc25db6-e592-4e7b-82aa-b7ea9dd7f1ee
# ╠═516589ec-3f40-4870-9a37-8e030cf1c951
# ╠═6617f059-c2ad-461e-8e83-73c85441ab5d
# ╠═9368f7d5-48d2-445c-a55b-2fcc2bf21f8d
# ╟─96166eaa-561b-4ef5-b2d4-f649f0f2dae2
# ╠═e0a7bb44-20f7-40b1-9597-a6f0ec1162f0
# ╟─2592fa9a-4194-4206-ac8b-e9727d63b550
# ╠═95e08b94-ba07-47e5-8982-8719d1af8877
# ╠═820238fb-a140-4f38-b58b-745df9b6cf5b
# ╠═5d57883d-c34a-4e5f-9106-b6cad4050a66
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
