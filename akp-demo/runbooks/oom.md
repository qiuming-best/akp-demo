## General

## Out of memory

**Symptoms**: Pod unexpectedly dies with `OOMKilled` status.

**Root cause**: The pod is consuming more memory than the available memory.

**Solution**: 

* Temporary increase the memory limit of the pod
* Increase the memory limit with the 20 Mb increment until the pod is stable.
* Remind team on slack to investigate the root cause of the memory leak.
