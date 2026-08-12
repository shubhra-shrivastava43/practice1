datarg = {
  rg1 = {
    name     = "rg-chor"
    location = "eastus"

  }
  rg2 = {
    name     = "data_rg1"
    location = "eastus"
  }
}

datavnet = {
  vnet1 = {
    name                = "vnet-chor"
    location            = "eastus"
    resource_group_name = "rg-chor"
    address_space       = ["10.0.0.0/16"]
  }

}

datasubnet = {
  subnet1 = {
    name                 = "frontend-subnet"
    virtual_network_name = "vnet-chor"
    resource_group_name  = "rg-chor"
    address_prefix       = ["10.0.1.0/24"]
  }

  subnet2 = {
    name                 = "backend-subnet"
    virtual_network_name = "vnet-chor"
    resource_group_name  = "rg-chor"
    address_prefix       = ["10.0.2.0/24"]
  }
}

nsg = {
  nsg1 = {
    name                 = "nsgdev"
    location             = "eastus"
    resource_group_name  = "rg-chor"
    subnet_name          = "frontend-subnet"
    virtual_network_name = "vnet-chor"
  }

  nsg2 = {
    name                 = "nsgprod"
    location             = "eastus"
    resource_group_name  = "rg-chor"
    subnet_name          = "backend-subnet"
    virtual_network_name = "vnet-chor"
  }

}

public_ip = {
  publicip1 = {
    name                = "frontend-pip"
    location            = "eastus"
    resource_group_name = "rg-chor"
    allocation_method   = "Static"

  }

  publicip2 = {
    name                = "backend-pip"
    location            = "eastus"
    resource_group_name = "rg-chor"
    allocation_method   = "Static"

  }
}

# kv={
#     kv1={
#         name = "prodkeyvalut"
#         location = "eastus"
#         resource_group_name = "rg-chor"
#         username = "shubhra"

#         password = "Shubhra@2026"


#     }
# }

# username={
#     username1={
#         
#         value="Shubhra
#     }
# }

# password={
#     password1={
#         
#         value="Shubhra@2026"
#     }
# }


kv = {
  kv1 = {
    name                = "devloperkv"
    location            = "eastus"
    resource_group_name = "rg-chor"
    username            = "shubhra"

    password = "Shubhra@2026"


  }

  kv2 = {
    name                = "prokv"
    location            = "eastus"
    resource_group_name = "rg-chor"
    username            = "shubhradevops"

    password = "Shubhra@2025"


  }
}



VM = {
  VM1 = {
    nicname                       = "frontend-vm-nic"
    location                      = "eastus"
    resource_group_name           = "rg-chor"
    virtualnetworkname            = "vnet-chor"
    subnet_name                   = "frontend-subnet"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_name        = "frontend-pip"
    vm_name                       = "frontend-vm"
    vm_size                       = "Standard_D2ds_v7"
    #admin_username="shubhra"
    #admin_password="Shubhra@2026"
    keyvalut_name = "devloperkv"
    vm-username   = "vm-username"
    vm-password   = "vm-password"






  }

  VM2 = {
    nicname                       = "backend-vm-nic"
    location                      = "eastus"
    resource_group_name           = "rg-chor"
    virtualnetworkname            = "vnet-chor"
    subnet_name                   = "backend-subnet"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_name        = "backend-pip"
    vm_name                       = "backend-vm"
    vm_size                       = "Standard_D2ds_v7"
    #admin_username="shubhra"
    #admin_password="Shubhra@2026"
    keyvalut_name = "devloperkv"
    vm-username   = "vm-username"
    vm-password   = "vm-password"





  }
}
