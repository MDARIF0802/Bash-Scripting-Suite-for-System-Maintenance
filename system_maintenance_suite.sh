#!/bin/bash
# ===========================================================
# System Maintenance Suite (macOS & Linux Compatible)
# Assignment 5 (Linux OS and LSP)
# Author: Md Arif
# ===========================================================

# ---------------------------
# CONFIGURATION VARIABLES
# ---------------------------
SOURCE="/Users/$USER/Documents"              # Default backup source
BACKUP_DEST="/Users/$USER/Backups"           # Backup destination
BACKUP_LOG="/Users/$USER/backup_log.txt"     # Backup log file

SYS_LOG="/Users/$USER/system_update_log.txt" # System update log
ALERT_LOG="/Users/$USER/alerts.txt"          # Log monitoring file
SYSTEM_LOG_FILE="/var/log/system.log"        # macOS system log file

# Ensure backup directory exists
mkdir -p "$BACKUP_DEST"

# ---------------------------
# FUNCTION: Backup System
# ---------------------------
backup_system() {
    echo "========== SYSTEM BACKUP =========="
    DATE=$(date +"%Y-%m-%d_%H-%M-%S")
    BACKUP_FILE="$BACKUP_DEST/backup_$DATE.tar.gz"

    echo "[$(date)] Starting backup..." >> "$BACKUP_LOG"

    if [ -d "$SOURCE" ]; then
        if tar -czf "$BACKUP_FILE" "$SOURCE" 2>>"$BACKUP_LOG"; then
            echo "[$(date)] Backup successful: $BACKUP_FILE" >> "$BACKUP_LOG"
            echo "✅ Backup completed successfully."
        else
            echo "[$(date)] Backup failed!" >> "$BACKUP_LOG"
            echo "❌ Backup failed. Check $BACKUP_LOG for details."
        fi
    else
        echo "[$(date)] Source directory not found: $SOURCE" >> "$BACKUP_LOG"
        echo "⚠️ Source directory not found!"
    fi
}

# ---------------------------
# FUNCTION: Update & Clean System
# ---------------------------
update_cleanup() {
    echo "========== SYSTEM UPDATE & CLEANUP =========="
    echo "[$(date)] Starting system update..." >> "$SYS_LOG"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS update (softwareupdate requires sudo)
        echo "Running macOS software update..." >> "$SYS_LOG"
        softwareupdate -l >> "$SYS_LOG" 2>&1
        echo "To install updates, run: sudo softwareupdate -i -a" >> "$SYS_LOG"
        echo "⚙️ macOS update check completed (manual install may be needed)."
    else
        # Linux (APT)
        if sudo apt update && sudo apt upgrade -y >> "$SYS_LOG" 2>&1; then
            echo "[$(date)] System updated successfully." >> "$SYS_LOG"
            echo "✅ System updated successfully."
        else
            echo "[$(date)] System update failed!" >> "$SYS_LOG"
            echo "❌ System update failed. Check $SYS_LOG."
        fi

        echo "[$(date)] Performing cleanup..." >> "$SYS_LOG"
        sudo apt autoremove -y >> "$SYS_LOG" 2>&1
        sudo apt autoclean -y >> "$SYS_LOG" 2>&1
        echo "[$(date)] Cleanup complete." >> "$SYS_LOG"
        echo "🧹 Cleanup completed."
    fi
}

# ---------------------------
# FUNCTION: Monitor Logs
# ---------------------------
monitor_logs() {
    echo "========== LOG MONITORING =========="
    KEYWORDS=("error" "fail" "critical")

    echo "[$(date)] Monitoring logs for issues..." >> "$ALERT_LOG"
    echo "Checking last 100 lines of system logs for alerts..."

    if [ -f "$SYSTEM_LOG_FILE" ]; then
        tail -n 100 "$SYSTEM_LOG_FILE" | while read LINE; do
            for WORD in "${KEYWORDS[@]}"; do
                if echo "$LINE" | grep -iq "$WORD"; then
                    echo "[$(date)] ALERT: Found '$WORD' -> $LINE" >> "$ALERT_LOG"
                fi
            done
        done
        echo "🔍 Log monitoring complete. Check $ALERT_LOG for alerts."
    else
        echo "⚠️ System log file not found: $SYSTEM_LOG_FILE"
        echo "[$(date)] Log file not found." >> "$ALERT_LOG"
    fi
}

# ---------------------------
# MAIN MENU FUNCTION
# ---------------------------
show_menu() {
    while true; do
        echo "===================================="
        echo "   🔧 System Maintenance Suite"
        echo "   Developed by: Md Arif"
        echo "===================================="
        echo "1. Run Backup"
        echo "2. Update & Clean System"
        echo "3. Monitor Logs"
        echo "4. Exit"
        echo "------------------------------------"
        read -p "Enter your choice [1-4]: " choice

        case $choice in
            1)
                backup_system
                ;;
            2)
                update_cleanup
                ;;
            3)
                monitor_logs
                ;;
            4)
                echo "Exiting Maintenance Suite... 👋"
                exit 0
                ;;
            *)
                echo "⚠️ Invalid option! Please try again."
                ;;
        esac

        echo ""
        read -p "Press Enter to continue..."
        clear
    done
}

# ---------------------------
# START THE PROGRAM
# ---------------------------
show_menu
