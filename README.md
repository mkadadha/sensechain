# SenseChain: A Blockchain-based Crowdsensing Framework for Multiple Requesters and Multiple Workers

SenseChain, is a decentralized crowdsensing framework developed for blockchain to mitigate the challenges of centralized deployment while increasing users’ engagement, with reasonable cost. 

The current version is developed on the Ethereum network using Solidity Language. 
It has Smart Contracts: 
<ol>
  <li> <i>User Manager Contract</i>: is a directory for registered, requesters and workers, registered and their information. The information is the <i>Ethereum Address</i>, <i>user type</i>, <i>Reputation</i> and <i>statistics</i>.

  <li> <i>Task Manager Contract</i>: is a directory for pending
tasks with their general information encapsulated into a Task objects.
<li> <i>Task Detailed Contract</i>: is responsible for the process of each task and holds the reservations and submissions for that task in addition to its general information.
</ol>

# Research Team
<b>PhD Candidate</b>

Maha Kadadha (Khalifa University, UAE) 

<b>Research Supervisors</b>

Hadi Otrok (Khalifa University, UAE)

Rabeb Mizouni (Khalifa University, UAE)

Shakti Singh (Khalifa University, UAE)

Anis Ouali (EBTIC, UAE)

# Abstract
In this paper, we propose a decentralized crowdsensing framework for multiple requesters with multiple workers built on Ethereum blockchain- SenseChain. Crowdsensing frameworks utilize workers’ sensing capabilities to fulfill requesters’ sensing tasks. While crowdsensing is typically managed by a centralized platform, the centralized management entails various challenges such as reliability in workers’ selection, fair evaluation for payment distribution, potential breach of users’ privacy, and high deployment cost. The proposed solution, SenseChain, is a decentralized crowdsensing framework developed to run on Ethereum blockchain to mitigate said challenges while increasing users’ engagement, with reasonable cost. SenseChain is developed around three smart contracts: (1) User Manager Contract (UMC), (2) Task Manager Contract (TMC), and (3) Task Detailed Contract (TDC). These contracts implement the platform features such as maintaining users’ information, publishing tasks from multiple requesters, accepting reservations and solutions from multiple workers, and evaluating solutions to calculate proportional payments. The framework is implemented using Solidity and Web3.js, where a real publicly available dataset is used. The framework performance is compared to a centralized greedy selection framework to demonstrate its comparability while mitigating tackled challenges. The results in terms of solutions quality, time cost, and workers traveled distance confirm its viability as a solution for crowdsensing.

# Citation
If you are using any part of SenseChain, please cite our paper.
<a href="https://www.sciencedirect.com/science/article/abs/pii/S0167739X19312579">Journal</a> |
<a href="https://www.researchgate.net/publication/338029700_SenseChain_A_blockchain-based_crowdsensing_framework_for_multiple_requesters_and_multiple_workers">ResearchGate</a> | <a href="https://www.youtube.com/watch?v=dtVfuHliFgU&t=12s">Youtube</a> 

<b> Text </b>
Maha Kadadha, Hadi Otrok, Rabeb Mizouni, Shakti Singh, Anis Ouali, SenseChain: A blockchain-based crowdsensing framework for multiple requesters and multiple workers, Future Generation Computer Systems, Volume 105, 2020, Pages 650-664, ISSN 0167-739X, DOI: https://doi.org/10.1016/j.future.2019.12.007.

<b> BibTex </b>
@article{KADADHA2020650,
title = "SenseChain: A blockchain-based crowdsensing framework for multiple requesters and multiple workers",
journal = "Future Generation Computer Systems",
volume = "105",
pages = "650 - 664",
year = "2020",
issn = "0167-739X",
doi = "https://doi.org/10.1016/j.future.2019.12.007",
url = "http://www.sciencedirect.com/science/article/pii/S0167739X19312579",
author = "Maha Kadadha and Hadi Otrok and Rabeb Mizouni and Shakti Singh and Anis Ouali",
keywords = "Crowdsensing, Blockchain, Smart contracts, Reputation, Decentralized",
abstract = "In this paper, we propose a decentralized crowdsensing framework for multiple requesters with multiple workers built on Ethereum blockchain- SenseChain. Crowdsensing frameworks utilize workers’ sensing capabilities to fulfill requesters’ sensing tasks. While crowdsensing is typically managed by a centralized platform, the centralized management entails various challenges such as reliability in workers’ selection, fair evaluation for payment distribution, potential breach of users’ privacy, and high deployment cost. The proposed solution, SenseChain, is a decentralized crowdsensing framework developed to run on Ethereum blockchain to mitigate said challenges while increasing users’ engagement, with reasonable cost. SenseChain is developed around three smart contracts: (1) User Manager Contract (UMC), (2) Task Manager Contract (TMC), and (3) Task Detailed Contract (TDC). These contracts implement the platform features such as maintaining users’ information, publishing tasks from multiple requesters, accepting reservations and solutions from multiple workers, and evaluating solutions to calculate proportional payments. The framework is implemented using Solidity and Web3.js, where a real publicly available dataset is used. The framework performance is compared to a centralized greedy selection framework to demonstrate its comparability while mitigating tackled challenges. The results in terms of solutions quality, time cost, and workers traveled distance confirm its viability as a solution for crowdsensing."
}
