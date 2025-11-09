🧭 System Maintenance Suite (Bash for Linux)

A menu-driven Bash scripting suite built for Linux system automation, designed to perform essential maintenance tasks such as backups, system updates, cleanup, and log monitoring — all from the terminal.
This project demonstrates the use of shell scripting, automation, logging, and error handling to manage Linux system health effectively.

📂 Features

✅ Automated Backup: Creates compressed backups of important directories
✅ System Update & Cleanup: Updates packages, removes unused files, and clears cache
✅ Log Monitoring: Detects critical errors and warnings in system logs
✅ Interactive Menu: Unified interface to access all maintenance operations
✅ Error Handling & Logging: Tracks every action and error with timestamped logs

⚙️ Requirements

Operating System: Linux (Ubuntu / Debian recommended)

Shell: Bash (v4 or above)

Permissions: sudo privileges required for update and cleanup

Tools Used:

tar – for creating compressed backups

apt – for system updates and cleanup

grep, tail – for log monitoring

date, mkdir – for automation and logging

🚀 How to Run

Clone the Repository

git clone https://github.com/<your-username>/system-maintenance-suite.git
cd system-maintenance-suite


Make the Script Executable

chmod +x system_maintenance_suite.sh


Run the Maintenance Suite

./system_maintenance_suite.sh

🧩 Menu Options
Option	Description
1️⃣	Run Backup of /home/$USER/Documents directory
2️⃣	Perform System Update & Cleanup
3️⃣	Monitor System Logs for errors, failures, or critical issues
4️⃣	Exit the Suite

1️⃣ Run Backup

Creates a compressed backup in /home/$USER/Backups


2️⃣ System Update & Cleanup

Updates packages, removes unnecessary ones, and cleans the system cache
![Uploading image.png…]()



3️⃣ Monitor Logs

Checks /var/log/syslog for keywords like error, fail, and critical
<img width="980" height="402" alt="image" src="https://github.com/user-attachments/assets/dbd137c6-0ba5-447e-ab1c-723314cb1332" />

4️⃣ Menu Interface

Simple, clear, and user-friendly text-based menu for all operations

📁 Output Files
File	Description
/home/$USER/Backups/backup_<timestamp>.tar.gz	Backup archive
/home/$USER/backup_log.txt	Backup operation logs
/home/$USER/system_update_log.txt	System update and cleanup logs
/home/$USER/alerts.txt	Log monitoring alerts

🛠️ Technologies Used

Bash Scripting

Linux Command Line Tools

System Administration Concepts

APT Package Management

Automation and Logging

🏁 Objective

To automate routine Linux system maintenance tasks using Bash scripting — improving system reliability, simplifying administrative work, and demonstrating practical Linux OS knowledge.


📜 License
This project is open-source and available under the MIT License.
