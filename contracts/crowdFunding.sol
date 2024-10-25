// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

contract CrowdFunding {
    struct Campaign {
        
        address owner;
        string title;
        string desc;
        uint256 target;
        uint256 timeframe;
        uint256 amountCollected;
        bool payOut;
       
    }

    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0;

    function Funding(
        address _owner,
        string memory _title,
        string memory _desc,
        uint256 _target,
        uint256 _timeframe
      
    ) public returns (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns];

        require(
            _timeframe > block.timestamp,
            "The due date must be set for a future time."
        );

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.desc = _desc;
        campaign.target = _target;
        campaign.timeframe = _timeframe;
        campaign.amountCollected = 0;
       

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }

    function payment(uint256 _id) public {
        Campaign storage campaign = campaigns[_id];

        require(
            msg.sender == campaign.owner,
            "Only the campaign owner should be able to withdraw funds"
        );
        require(!campaign.payOut, "Funds already withdrawn");

        uint256 payoutAmount = campaign.amountCollected;
        require(payoutAmount > 0, "No funds to withdraw");

        campaign.amountCollected = 0;
        campaign.payOut = true;

        (bool sent, ) = payable(campaign.owner).call{value: payoutAmount}("");
        require(sent, "Failed to send funds to the campaign owner");
    }
}