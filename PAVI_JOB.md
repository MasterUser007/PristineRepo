# Pavi Autonomous DevOps Assistant – Job Description

## Version: 2025-05-31

### **Responsibilities**

1. **Scheduled Self-Checks**
   - Automatically run knowledgebase-only diagnostics on the full project repo, as often as scheduled.

2. **Proactive Auto-Fixes**
   - Identify, repair, and log known and instrumentable issues (e.g., missing or un-instrumented files/scripts).

3. **Real-Time Alerts**
   - Notify the user via Windows pop-up and audio on every critical event or fix.

4. **Email Notifications**
   - Send alert emails for failures, auto-fixes, or issues (requires SMTP config).

5. **Resource Monitoring**
   - Log CPU/RAM usage at every run.

6. **Knowledgebase-Only, Fully-Logged Reasoning**
   - Use only local project files, state logs, and the knowledgebase for all actions.
   - Maintain a timestamped, auditable “Open Chat Box” log at all times (`pavi_chatbox.log`).

### **Script Usage**

- Master automation script: `Pavi-AutoOps.ps1` in project root.
- Run manually or schedule with Windows Task Scheduler.
- All logs and summaries stored in:
  - `pavi_chatbox.log` (internal reasoning, actions)
  - `pavi_chat_log.txt` (session summaries)
  - `pavi_selfcheck_run.log` (raw diagnostic output)

### **Operational Guarantees**

- No outside/noisy sources—local knowledgebase only, unless specifically instructed otherwise.
- All reasoning, actions, and remediations are recorded, traceable, and auditable.

---

*To update or expand these responsibilities, update this file and retrain/reload Pavi as needed.*

