<!--
Please fill out the following template to the best of your ability.
If you're not sure about something, feel free to ask for help in Discord or the Discussions.
The more information you provide, the easier it will be to help you.
Issues that completely ignore this template will be closed.
-->

# Expected behavior

Describe your expected behavior.

## Actual behavior

Describe the actual behavior.

# Steps to reproduce the behavior

Outline the steps to reproduce the issue you've encountered.

# Additional context

## Quickemu output

Run `quickemu` or `quickemu` and include the output of the failure below:

<details>
  <summary>Quickemu output</summary>

  ```text
  quickemu/quickget output here
  ```
</details>

## System Information

**Run `quickreport` and include the output here**; if you can't run `quickreport`,
please provide the output of the following:

```bash
clear && \
echo -e "Ver:\t$(quickemu --version)" && \
echo -e "Distro:\t$(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)" && \
echo -e "Kernel:\t$(uname -s -r -m)" && \
echo -e "Memory:\t$(free --si -h | awk '/Mem:/{print $2}')" && \
lspci | grep -i vga | cut -d':' -f3 && echo && \
curl --version && echo && \
qemu-system-"$(uname -m)" -version | head -1 && \
qemu-system-"$(uname -m)" -cpu help && echo && \
lscpu | tee quickreport.txt
```

<details>
  <summary>Quickreport output</summary>

  ```text
  quickreport output here
  ```
</details>
