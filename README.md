## Disclaimers

This is for a hacked testing of the direct-assign feature for Kata Containers. It is expected that the storage that is being setup
would be put into place via a CSI plugin. This is a way to manually set it up standalone for basic testing.

setup-pv.sh will make use of /dev/loop20-23. You will likely need to adjust this based
on usage on your system.

## Quick test

This setup assumes access to a host where the container will run (ie, through ctr or single node kubernetes cluster)

### Setup storage on host

Create block device, as well as normal mountpoints:
```
$ ./setup-pv.sh
```

### Test with ctr
Using ctr, we can then test direct assigned volumes:
 - RO volume - `/tmp/directvolume-testing/da-1`
 - RW volume - `/tmp/directvolume-testing-da-2`

To test:

ro:
```
sudo ctr run --rm --mount type=bind,src=/tmp/directvolume-testing/da-1,dst=/test,options=rbind:ro --runtime io.containerd.kata.v2 -t docker.io/library/busybox:latest test-da-1 sh
```

rw:
```
sudo ctr run --rm --mount type=bind,src=/tmp/directvolume-testing/da-2,dst=/test,options=rbind --runtime io.containerd.kata.v2 -t docker.io/library/busybox:latest test-da-1 sh
```

### Test with kubernetes

YMMV - PV make use of a host affinity that'll need to match with users hostname (currently `ubuntu` since this is hacked together in an ubuntu VM).

Apply the PV, PVCs, and run test.yaml...

