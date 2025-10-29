// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedChecklist {
    
    // Structure to represent each task
    struct Task {
        string description;
        bool isCompleted;
    }

    // Mapping of user address → list of tasks
    mapping(address => Task[]) private userTasks;

    // Add a new task to the checklist
    function addTask(string memory _description) public {
        userTasks[msg.sender].push(Task({
            description: _description,
            isCompleted: false
        }));
    }

    // Mark a task as completed
    function markTaskCompleted(uint _index) public {
        require(_index < userTasks[msg.sender].length, "Invalid task index");
        userTasks[msg.sender][_index].isCompleted = true;
    }

    // Get all tasks of the sender
    function getMyTasks() public view returns (Task[] memory) {
        return userTasks[msg.sender];
    }

    // Calculate progress (percentage of tasks completed)
    function getProgress() public view returns (uint) {
        Task[] memory tasks = userTasks[msg.sender];
        uint total = tasks.length;
        if (total == 0) return 0;

        uint completed = 0;
        for (uint i = 0; i < total; i++) {
            if (tasks[i].isCompleted) {
                completed++;
            }
        }

        return (completed * 100) / total; // percentage
    }
}
