// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract RussianWinterRitualsRegistry {

    struct WinterTradition {
        string ritualName;          // Northern Maslenitsa, Central Maslenitsa, Volga Ice Songs, etc.
        string region;              // North, Central Russia, South, Volga, Arctic
        string symbolicElements;    // fire, masks, effigies, sun symbols
        string practices;           // burning effigies, dances, songs, processions
        string musicalFeatures;     // circular chants, fast rhythms, drone singing
        string culturalContext;     // end of winter, fertility rites, community gatherings
        string uniqueness;          // regional identity, rare ritual forms
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct WinterInput {
        string ritualName;
        string region;
        string symbolicElements;
        string practices;
        string musicalFeatures;
        string culturalContext;
        string uniqueness;
    }

    WinterTradition[] public traditions;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event WinterRecorded(uint256 indexed id, string ritualName, address indexed creator);
    event WinterVoted(uint256 indexed id, bool like, uint256 likes, uint256 dislikes);

    constructor() {
        traditions.push(
            WinterTradition({
                ritualName: "Example (replace manually)",
                region: "example",
                symbolicElements: "example",
                practices: "example",
                musicalFeatures: "example",
                culturalContext: "example",
                uniqueness: "example",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordWinter(WinterInput calldata w) external {
        traditions.push(
            WinterTradition({
                ritualName: w.ritualName,
                region: w.region,
                symbolicElements: w.symbolicElements,
                practices: w.practices,
                musicalFeatures: w.musicalFeatures,
                culturalContext: w.culturalContext,
                uniqueness: w.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit WinterRecorded(traditions.length - 1, w.ritualName, msg.sender);
    }

    function voteWinter(uint256 id, bool like) external {
        require(id < traditions.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;
        WinterTradition storage w = traditions[id];

        if (like) w.likes++;
        else w.dislikes++;

        emit WinterVoted(id, like, w.likes, w.dislikes);
    }

    function totalWinterTraditions() external view returns (uint256) {
        return traditions.length;
    }
}
