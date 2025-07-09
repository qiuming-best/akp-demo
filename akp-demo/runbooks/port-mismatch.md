# Runbook: Resolving CrashLoopBackOff from Probe Port Mismatch

## General

- First, do the initial triage and collect the basic information to understand the incident.
- Next, send a slack notification with the link to the conversation to channel "REPLACE ME" with basic detail.
- Next, work on the incident according to the runbook. Don't take any action automatically, ask for approval.
- If the app is stable, check 30 seconds later again, then you can close the incident automatically. Please do slack all the details in concise messages.
- If you stack send a slack message again and mention that you need help.
- Please ensure you send slack message with the link to the conversation, so engineer can work with you together if needed.

## 1. Detection
- Observe pods in a `CrashLoopBackOff` state in Argo CD or with `kubectl get pods`.
- In Argo CD UI, check the resource tree for 'Degraded' Deployments/Pods.

## 2. Initial Diagnosis
- Review pod/container status:
  - Look for exit codes, especially `2` (command/port/config errors).
  - Check for repeated restarts or failing probes (not ready / unhealthy).

## 3. Log & Spec Investigation
- Retrieve container logs:
  - `kubectl logs <pod-name> -n <namespace>`
- If logs are empty or fail instantly, inspect the spec:
  - Check container `command`/`args`—what port is the app listening on?
  - Check `livenessProbe` and `readinessProbe` ports and paths.

## 4. Root Cause Identification
- Are the probe ports different from the app's listening port? (e.g., probe = `30000`, app = `3000`)
- If mismatched, probes will fail, resulting in restart loops.

## 5. Patch and Remedy
- Update deployment manifest:
  - Set `livenessProbe.httpGet.port` and `readinessProbe.httpGet.port` to match the app's actual port.
- Validate the patch (dry run if possible).
- Apply the patch and monitor the rollout/recovery.

## 6. Post-fix Validation
- Ensure new pods start successfully and all probes pass (using Argo CD UI and/or `kubectl`).
- Confirm there are no further CrashLoopBackOff events.
- Review app logs to ensure it starts cleanly.
