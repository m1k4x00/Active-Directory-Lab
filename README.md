# Active-Directory-Lab

## 1. Introduction

The goal of this project is to create a simple virtual Active Directory environment using VirtualBox which can be used to practice defensive and offensive tacticts.
The topology of the environment is visualized in the following picture.

## 2. Installing and setting up the Virtual Machines

### 2.1. Server (Domain Controller)
As the domain controller we'll be using Microsoft Windows Server 2019 with a standard setup.
We will add an additional network adapter for the internal network
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/272fef05-0051-4b60-98cc-770b17f0f069)

We will also need to configure the internal network on the machine itself based on the topology picture.

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/8b2a2f5c-4e6a-4aff-a7b7-4519076ce9d6)

## 3. Creating the Active Directory Domain (Server)

### 3.1 Adding Active Directory Domain Services
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/fe31ddee-aa68-4920-a399-a252b3f78f9c)

### 3.2 Promoting Server to Domain Controller
Otherwise default seutp but the domain name is changed
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/fc8dfae3-f372-4a87-8c1f-c0b1c818f4cb)

## 4. Creating a Admin user in Active Directory
We will start off by creating a new organizational unit for admin users.
Then we'll create a Admin user called Michael

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/1100866d-7a8b-4195-a080-e148a1642175)

After the Admin user has been created we will add the user to the Domain Admins group

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/98653863-6c7c-4142-8877-317586be74f9)

## 5. Installing and Setting Up RAS/NAT

### 5.1 Installation
The function of RAS/NAT is to allow the clients of the domain controller to access the Internet through the Domain Controller
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/450a037e-8dd2-49b6-b0d7-222df3b226cc)![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/7125c65c-c750-4912-a3c2-4e1e4710c5c2)

From the Server Manager we will install Remote Access and enable Routing from the Role Services tab

### 5.2 Setup 
First we select the Routing and Remote Access tool from the tool menu of Server Manager run the setup wizard and choose the NAT option
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/5d039f90-d302-4434-9809-faddb4f2fe2f)
Then We choose the Internet facing adapter form the list and finish the setup

## 6. Installing and Setting Up the DHCP Server
The DHCP server will allow the Windows clients to get an ip address to connect to the Internet

### 6.1 Installation
To enable DHCP server we will once again use the Server Manager's Add Roles and Features wizard.
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/860c0026-343f-4381-b298-554ce1b61448)

### 6.2 Setup
From the tool menu we select DHCP
From the topology diagram we can see that we assigned the ip range of 172.16.0.100-200 for the DHCP server.

Next we add the scope for the DHCP server using the New Scope Wizard
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/8f9fed6e-eec6-49f8-a445-9397f388f016)

After that the wizard will ask as to enter the Default Gateway for our clients. From the diagram we have assigned it as 172.16.0.1 (Domain Controllers ip address)

## 7. Automaing Adding Users to AD using PowerShell
The scirpt is awailabe in this repository
