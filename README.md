# Broadcom PCI/PCIe SDK
This package is intended for use with CI tools to ensure that other programs have this dependency if they need it. It's
**not** intended to be used to replace an actually installation of this software. I provide installation instructions 
below for a typical installation.  

The code contained in this repository comes from Broadcom_PCI_PCIe_SDK_Linux_v8_00_Final_2019-07-30.tar.gz. 

## Installation Instructions for CentOS 8
1. [Download the v8.00 SDK](https://www.broadcom.com/products/pcie-switches-bridges/software-dev-kits#downloads) to your system.
2. Extract the tarball and move it to `/usr/local/broadcom/8.00`
   ```shell script
   [user@localhost ~]$ tar xzf Broadcom_PCI_PCIe_SDK_Linux_v8_00_Final_2019-07-30.tar.gz
   [user@localhost ~]$ sudo mkdir /usr/local/broadcom
   [user@localhost ~]$ sudo mv PlxSdk /usr/local/broadcom/8.00
   [user@localhost ~]$ sudo ln -s /usr/local/broadcom/8.00 /usr/local/broadcom/current
   ```
2. Export the `PLX_SDK_DIR` environment variable in `/etc/profile.d/broadcom.sh`
   ```shell script
   [user@localhost ~]$ echo -e "export PLX_SDK_DIR=/usr/local/broadcom/current\n" | sudo tee /etc/profile.d/broadcom.sh > /dev/null
   [user@localhost ~]$ source /etc/profile.d/broadcom.sh
   ```
2. Update `Include/Plx_sysdep.h::access_ok` to allow building on the CentOS modified Linux 4.18+ kernels.
   ```c
   /***********************************************************
    * access_ok
    *
    * access_ok() removed type param in 5.0
    **********************************************************/
   #if (LINUX_VERSION_CODE < KERNEL_VERSION(4,0,0))
       #define Plx_access_ok                     access_ok
   #else
       #define Plx_access_ok(type,addr,size)     access_ok( (addr),(size) )
   #endif
   ```
2. Build the API library
   ```shell script
   [user@localhost ~]$ sudo make -C ${PLX_SDK_DIR}
   ```
3. Build the driver
   ```shell script
   [user@localhost ~]$ sudo -E PLX_CHIP=9054 make -C ${PLX_SDK_DIR}/Driver/
   ```
4. Load the kernel driver
    ```shell script
    [user@localhost ~]$ sudo -E ${PLX_SDK_DIR}/Bin/Plx_load 9054
    ```

## Disclaimer
**This software is not supported or maintained by Broadcom** The original software can be obtained from 
[Broadcom](https://www.broadcom.com/products/pcie-switches-bridges/software-dev-kit)

