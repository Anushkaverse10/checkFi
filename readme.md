# 🧾 Decentralized Checklist with Progress Tracking

A simple **Solidity smart contract** that allows users to create and manage their own **decentralized task lists** directly on the blockchain.  
Each user can add tasks, mark them as completed, and track their overall progress in percentage.

---
<img width="1918" height="963" alt="image" src="https://github.com/user-attachments/assets/fdc421f5-be05-4c8f-bc19-0d66504bedf0" />


## 🚀 Features

- Add new checklist tasks  
- Mark tasks as completed  
- View your personal checklist  
- Track progress (completion percentage)  
- Fully decentralized — each user's tasks are private and stored on-chain

---





## 🧠 Smart Contract Overview

**Contract Name:** `DecentralizedChecklist`  
**Language:** Solidity `^0.8.0`  
**License:** MIT

### Functions

| Function | Description |
|-----------|--------------|
| `addTask(string _description)` | Adds a new task to your personal checklist. |
| `markTaskCompleted(uint _index)` | Marks a task as completed using its index. |
| `getMyTasks()` | Returns all tasks created by the sender. |
| `getProgress()` | Returns the percentage of tasks completed. |

---

## 💻 Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedChecklist {
    
    struct Task {
        string description;
        bool isCompleted;
    }

    mapping(address => Task[]) private userTasks;

    function addTask(string memory _description) public {
        userTasks[msg.sender].push(Task({
            description: _description,
            isCompleted: false
        }));
    }

    function markTaskCompleted(uint _index) public {
        require(_index < userTasks[msg.sender].length, "Invalid task index");
        userTasks[msg.sender][_index].isCompleted = true;
    }

    function getMyTasks() public view returns (Task[] memory) {
        return userTasks[msg.sender];
    }

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

        return (completed * 100) / total;
    }
}
