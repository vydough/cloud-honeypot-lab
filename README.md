# Cloud-native Honeypot For Attack Telemetry and Threat Analysis
An AWS-hosted honeypot that acts as a deliberately misconfigured site for self-study and analysis of live attack traffic. 

## Overview  
This project implements a cloud based honeypot environment designed to capture , monitor and analyse malicious activity targeting exposed internet services.

Deployed on an isolated cloud VM and intentionally exposed to attract automated scans, brute-force attempts and other hostile activity. 

Typical honeypot projects use T-pot, an all in one platform. However, as I wanted to understand the individual components involved by building it manually: 
    - Honeypot deployment
    - Network security
    - Loggin
    - Monitoring
    - Threat analysis

## Objective 
The project aims to collect attacker telemetry such as: 
    - Source IP
    - Attempted usernames and paswords
    - Commands entered in sessions
    - Connection timestamps
    - Other behavioural information

Collected logs are then forwarded to central monitoring platform (CloudWatch) for analysis. 

This project was intended for learning and research into malicious activitty and for gaining practical experience with cloud, Linux, threat monitoring and security analysis

## Key Features

**SSH/Telnet attack monitoring**
    - Uses Cowrie to emulate SSH and Telnet services.
    - Captures authentication attempts and interactive attacker sessions.

**Credential attempt logging**
    - Records usernames and passwords attempted by remote hosts.
    - Allows analysis of commonly targeted credentials.

**Command and session monitoring**
    - Records commands entered by attackers after connecting to the honeypot.
    - Provides insight into attacker behaviour and post-compromise activity.

**Source IP tracking**
    - Logs the IP addresses of systems connecting to the honeypot.
    - Enables identification of repeated scanners and attack sources.

**Structured JSON logging**
    - Uses structured honeypot logs to simplify searching, parsing, and analysis.

**Cloud log monitoring**
    - Honeypot logs can be forwarded to services such as AWS CloudWatch for analysis

**Attack visualisation**
    - attack frequency
    - source IP addresses
    - attempted usernames
    - attempted passwords
    - attacker commands
    - geographic distribution
    - attack trends over time

## Project Structure

## Project Process
### AWS EC2 Configuration 
### Cowrie 
### Exposing traffic
### Storing command logs
### Log ship to CloudWatch
### Building Dashboard


## Future Improvements



