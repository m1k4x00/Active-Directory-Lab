# Active-Directory-Lab

## 1. Introduction

The goal of this project is to create a simple virtual Active Directory environment using VirtualBox which can be used to practice defensive and offensive tacticts.
The topology of the environment is visualized in the following picture. After we have created the environment we are going to test varius attacks against the machines.

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/e8fafdd9-e879-41f3-b71a-824198737020)

## 2. Installing and setting up the Virtual Machines

### 2.1. Server (Domain Controller)
As the domain controller we'll be using Microsoft Windows Server 2019 with a standard install.
We will add an additional network adapter for the internal network
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/272fef05-0051-4b60-98cc-770b17f0f069)

We will also need to configure the internal network on the machine itself based on the topology picture.

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/8b2a2f5c-4e6a-4aff-a7b7-4519076ce9d6)

### 2.2 Client
As the cilent we'll use a stanadard Microsoft Windows 10 install.
By looking at our network topology diagram we can see that we need to set the netowrk adapter to Internal Network

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/d924dcaf-f306-4bdc-b057-14a7d0ba1173)

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

Lastly we will add the router option to the Server Options so the.

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/ff480e31-eac2-4d46-a63b-eb8671927cf3)

## 7. Automaing Adding Users to AD using PowerShell
The PowerShell script will first read the names of the users from names.txt and then create AD users based on those names.

The scirpt is awailabe in this repository

After the script is run the _USERS OU should look like this

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/27a6081f-f524-4b18-9f93-aceca9d70fc1)

## 8. Making Sure the Client Can Access the Internet
We can now see that the client can browse the Internet

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/8f7c8ba3-d14b-4de1-9437-ac5ca390a3c6)

## 9. Preperation For Attacks
Before we start attacking the environment we are going to add and change a few things.
First we will make a group policy to disable Windows Defender since the goal is not to demonstrate AV evasion.

### 9.1 New Users And Group
Next we will change our user structure. We will create a new Domain Administrator called Tom Stark, two new users called Frank Castle and Paul Parker and and SQLService account.
We will intentionally make the SQLService account a Domain Administrator for future attacks and write the password in the description which is surprisingly fairly common.

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/d5063dbe-3dd2-45b4-ac95-82022109e9af)

### 9.2 Creating a SMB Share
We will also create a new SMB share called vulnshare in the Server Manager for Domain Controller. We created the SMB share because most Domain Controllers have a share and we wanted to open ports 139 and 445.

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/c3e4dbff-c89a-460f-b7fe-a7965f60026b)

### 9.3 Setting SPN
We set a Service Principle Name for a future attack regarding Kerberoasting
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/d8f91561-b576-4252-8129-2073c5575772)

### 9.4 Adding a New Machine
We will also add a new machine resulting in the following topology

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/b7261856-fb7a-493e-931f-8e65ac1a51e8)

### 9.5 Adding Shared Folder to Both Machines
We add a folder named Share to CLIENT and CLIENT2 and share it to everyone

### 9.6 Joining CLIENT to the Domain
We join the computer to the Domain from Windows settings using the Access Work or School wizard

### 9.7 Adding Frank Castle as Local Administrator on CLIENT

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/b0dbad33-05d4-4197-b87e-fa883cb84d28)

### 9.8 Adding Frank Castle and Paul Parker as Local Administrator on CLIENT2

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/e486878b-42de-45c9-9e82-8086538ca1e1)

Now we have Frank Castle as the Local Administrator of both the client machines and Paul Parker Local Administrator of the CLIENT2 machine.

## 10. Demonstrating Different Attacks
Next we will demonstrate different attacks that can be done against a Active Directory environment. We assume that the attacker has access to the internal network. The attacker will use a Kali Linux machine to carry out the attacks.

## 10.1 LLMNR Poisoning

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/ddaf1ef7-ee73-46ac-95e4-17fbfa72959e)
*LLMNR poisoning process - Image by technologysolutions*
### 10.1.1 Overview
LLMNR stands for Link-Local Multicast Name Resolution. In LLMNR Poisoning the attacker listens and waits to intercept a request for the victim.

Let's go through the steps of a LLMNR Poisoning attack

1. The VICTIM wants to connect the server \\hackme but instead types \\hackm.
2. The DNS server doesn't know that host.
3. The DNS server then asks around the network to see if anyone else knows that host
4. The the ATTACKER acts as and man in the middle and tells the VICTIM to send their hash to the ATTACKER
5. The VICTIM now blindly sends their NTLMv2 hash to the ATTACKER.
6. Now the ATTACKER can crack the password of the VICTIM offline

There are various ways the ATTACKER can make the VICTIM type the wrong domain name or IP. 

### 10.1.2 Attack Demo

For the attack we will use a tool called Responder on our ATTACK machine to run the man in the middle attack using the following command on Kali Linux. 
When a DNS failure happends Responder captures the VICTIMs IP, username and NTMLv2 hash.
For simplicity we will assume that the VICTIM mistypes the ATTACKER machine IP when trying to open a file share

First we run Responder on our Kali mahcine
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/bdd3eb39-3481-4ab2-85e7-268db654311b)

Now when we try to connect to 172.16.0.101 (ATTACKER) from CLIENT as fcastle we get this
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/d7ef29f3-2323-4e21-854b-a15ece568f0e)

And on the attacker machine we can now see 
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/4e15df8e-73a4-4a72-81bd-e9a69e5bbf9f)

### 10.1.3 Cracking The Hash Using Hashcat
Finally we will try to crack the hash using Hashcat. From the hashcat typelist we can find the corresponding mode to NTMLv2 hash. It appears to be 5600.

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/b5c2d40d-8ad7-4a1a-bf88-eabfc8a0da38)

After the carcking was succesfull we get the password for fcastle
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/2a3c3aec-74c0-4774-bd66-302e08034772)
*fcastle:Password1*

### 10.1.3 LLMNR Poisoning Mitigation
How can we best defense agaist LLMNR Poisoning?

The best defence is to disable LLMNR and NBT-NS. We can turn off LLMNR by selecting "Turn OFF Multicast Name Resolution" under Local Computer Policy > Computer Configuration > Administrative Templates > Netowrk > DNS Client in the Group Policy Editor.
NBT-NS can be truned off by navigating to Network Connections > Network Adapter Properties > TCP/IPv4 Propertises > Advanced tab > WINS tab and by selecting "Disable NetBIOS over TCP/IP"

If for some reason LLMNR/NTB-NS must be used it is best to require Network Access Control and require strong user passwords.

## 10.2 SMB Relay

### 10.2.1 Overview
Instead of cracking the password hash gathered with Responder, we can instead relay those hashes to other machines and potentially gain access.

For SMB Relay to work there are some requirements.
1. SMB signing must be dsiabled on the victim machine
2. Relayed user credentials must be admin on the victim machine

### 10.2.2 Preperation And Setup
On our Responder.conf we will turn off SMB and HTTP servers so we will not respond with Responder.
For the relay attack we will use a python based tool called nmtlrelayx.py which is part of the Impacket library
We will also make sure that both CLIENT and CLIENT2 are discoverable to other machines.

### 10.2.3 Attack Demo

We will first need to determine wich machines on the network have SMB signing disabled. We can achieve this with a NMAP scan using smb2-security-mode script.

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/2f6eda03-dae2-4ecd-837d-06485fbd9aca)

We can see that for our Domain Controller (172.16.0.1) message signing is enabled and required. This means that we will not be able to do any relay attacks on the Domain Controller.
As for the client machines (172.16.0.100 and 172.16.0.102) we can see that message signing is enabled but not required which means that a relay attack is possible.

Now we can add those to targets.txt but for simplification we will only add CLIENT2 (172.16.0.102) since we know that fcastle is a local admin of that machine.
We will also edit the Responder.conf and turn off SMB and HTTP
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/61621d24-1efe-40db-88a9-47e5cfef4061)

Next we run Responder as we did before in chapter 10.1.2 but we will also setup the relay
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/54bf9937-d001-4eb5-8cfb-33f0f025c1d5)

Now we do the same missdirected share lookup as in NLMR Poisoning to retrieve the hash from CLIENT which we will then relay to CLIENT2
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/55f1ec11-ffee-4903-a3c4-5291b9dc1434)

We then recieve the local SAM hashes of the CLIENT2 machine
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/1f24fdfc-af3b-478e-bc05-781119d240a9)

We can try to crack these hashes offline or use to potentially move laterally or even vertically

### 10.2.4 Getting a Shell With nmtlrelayx.py
We can also try to get an interactive shell by adding "-i" to our command

![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/e791127d-aa94-47fc-9f7c-c75c7c3756ca)

we can see that the shell is running at 127.0.0.1:11001. We can connect to it using netcat
![image](https://github.com/m1k4x00/Active-Directory-Lab/assets/142576207/1e2450bd-4b48-45c9-92a7-93255e01ef47)

We could also, for example, use the wildcard "-e" to execute a Meterpreter reverse shell to gain a Meterpreter session.

### 10.2.5 SMB Relay Mitigation
To prevent SMB Relay attacks one tactic is to enable SMB Siginng on all devises. This completely stops the attacs but it might cause performace issues with fiel copies.
Disabling NTLM authentication on the network will completely stop the attack but if Kerberos stops working Windows will default back to NTLM.
You could also Limit domain admins to specific task but enforcing the policy may be difficult.
It is also possible to restrict local admins. This will prevent a lot of lateral movement but it might potentially increase the amount of service desk tickets.

## 10.3 Gaining Shell Access
