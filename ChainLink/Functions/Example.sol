// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/FunctionsClient.sol";
import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";
import {FunctionsRequest} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/libraries/FunctionsRequest.sol";

/**
 * @title WeatherChecker
 * @notice Gets current temperature for a city using Chainlink Functions
 * @dev Uses OpenWeatherMap API with secure secrets
 */
contract WeatherChecker is FunctionsClient, ConfirmedOwner {
    using FunctionsRequest for FunctionsRequest.Request;

    // Store latest data
    bytes32 public s_lastRequestId;
    int256 public s_temperature; // in Celsius
    string public s_city;

    // Events
    event RequestSent(bytes32 indexed requestId, string city);
    event TemperatureUpdated(bytes32 indexed requestId, string city, int256 tempC);

    // --- Chainlink Functions Configuration (Sepolia) ---
    address immutable router = 0x234a5fB5bd614A7aa2fFAB244D603abFA0Ac5C5C;
    bytes32 immutable donID = 0x66756e2d617262697472756d2d7365706f6c69612d3100000000000000000000;
    uint32 constant gasLimit = 250_000;

    // We'll set this in the constructor
    string public sourceCode;

    constructor(string memory initialCity) FunctionsClient(router) ConfirmedOwner(msg.sender) {
        s_city = initialCity;

        // The JS code will be set via a function so we can update it
        // We initialize it here
        updateSourceCode();
    }

    /**
     * @notice Updates the JavaScript source code
     * @dev Call this if you change logic or secrets
     */
    function updateSourceCode() public onlyOwner {
        sourceCode = string.concat(
            // Get API key from secrets
            'const apiKey = Functions.secrets.apiKey;',
            // Use city from args or fallback
            'const city = args.length > 0 ? args[0] : "London";',
            'if (!apiKey) { throw Error("API key not set"); }',
            'const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`;',
            'const response = await Functions.makeHttpRequest({ url });',
            'if (response.error) { throw Error("Request failed"); }',
            'const tempC = response.data.main.temp;',
            'return Functions.encodeInt256(Math.round(tempC * 100));' // Return as int (2 decimals)
        );
    }

    /**
     * @notice Request current temperature for a city
     * @param subscriptionId Your Chainlink Functions subscription ID
     * @param city Name of the city (optional)
     */
    function requestTemperature(
        uint64 subscriptionId,
        string calldata city
    ) external onlyOwner {
        FunctionsRequest.Request memory req;
        req.initializeRequestForInlineJavaScript(sourceCode);

        if (bytes(city).length > 0) {
            req.setArgs([city]);
        } else {
            req.setArgs([s_city]); // fallback
        }

        s_lastRequestId = _sendRequest(
            req.encodeCBOR(),
            subscriptionId,
            gasLimit,
            donID
        );

        emit RequestSent(s_lastRequestId, city);
    }

    /**
     * @notice Callback: receives temperature from Chainlink node
     */
    function fulfillRequest(
        bytes32 requestId,
        bytes memory response,
        bytes memory err
    ) internal override {
        if (err.length > 0) {
            revert("Request failed: ", string(err));
        }

        // Decode int256 (we sent temp * 100)
        s_temperature = Functions.decodeInt256(response);
        int256 tempWithDecimals = s_temperature / 100; // Convert back to °C

        emit TemperatureUpdated(requestId, s_city, tempWithDecimals);
    }

    /**
     * @notice Set default city
     */
    function setCity(string calldata city) external onlyOwner {
        s_city = city;
    }
}