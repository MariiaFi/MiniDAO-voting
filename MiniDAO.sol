// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/// @title MiniDAO Voting Contract v1.1 (with executable message update)
/// @author Mariia
/// @notice A simple DAO that allows voting to update a public message

contract MiniDAO {
    struct Proposal {
        string description;
        string newMessage; // The message to set if the proposal is executed
        uint voteCount;
        bool executed;
    }

    Proposal[] public proposals;

    mapping(address => mapping(uint => bool)) public hasVoted;

    address public admin;
    uint public quorum;

    string public publicMessage; // Message that can be changed through voting

    event ProposalCreated(uint indexed proposalId, string description, string newMessage);
    event Voted(address indexed voter, uint indexed proposalId);
    event ProposalExecuted(uint indexed proposalId, string newMessage);

    modifier onlyAdmin() {
        require(msg.sender == admin, "MiniDAO: caller is not admin");
        _;
    }

    /// @notice Initializes the DAO with a quorum and initial message
    constructor(uint _quorum, string memory _initialMessage) {
        require(_quorum > 0, "MiniDAO: quorum must be > 0");
        admin = msg.sender;
        quorum = _quorum;
        publicMessage = _initialMessage;
    }

    /// @notice Creates a new proposal (admin only)
    /// @param _description Description of the proposal
    /// @param _newMessage The message to set if this proposal is executed
    function createProposal(string calldata _description, string calldata _newMessage) external onlyAdmin {
        proposals.push(Proposal({
            description: _description,
            newMessage: _newMessage,
            voteCount: 0,
            executed: false
        }));

        emit ProposalCreated(proposals.length - 1, _description, _newMessage);
    }

    /// @notice Casts a vote for a specific proposal
    /// @param _proposalId The ID of the proposal to vote on
    function vote(uint _proposalId) external {
        require(_proposalId < proposals.length, "MiniDAO: invalid proposal");
        require(!hasVoted[msg.sender][_proposalId], "MiniDAO: already voted");

        proposals[_proposalId].voteCount += 1;
        hasVoted[msg.sender][_proposalId] = true;

        emit Voted(msg.sender, _proposalId);
    }

    /// @notice Executes a proposal if the quorum is met
    /// @param _proposalId The ID of the proposal to execute
    function executeProposal(uint _proposalId) external onlyAdmin {
        require(_proposalId < proposals.length, "MiniDAO: invalid proposal");

        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.executed, "MiniDAO: already executed");
        require(proposal.voteCount >= quorum, "MiniDAO: quorum not met");

        proposal.executed = true;
        publicMessage = proposal.newMessage;

        emit ProposalExecuted(_proposalId, proposal.newMessage);
    }

    /// @notice Returns all proposals
    function getProposals() external view returns (Proposal[] memory) {
        return proposals;
    }
}
