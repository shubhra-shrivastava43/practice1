module "azurerm_resource_group"{
    source="../../modules/azurerm_resource_group"
    datarg=var.datarg 

}

module "vnet"{
    source="../../modules/azurerm_vnet"

    depends_on = [ module.azurerm_resource_group ]
    datavnet = var.datavnet
}

module "subnet"{
    source="../../modules/azurerm_subnet"
    depends_on = [ module.vnet ]
    datasubnet = var.datasubnet
}

module "nsg"{
    source="../../modules/azurerm_NSG"
    depends_on = [ module.azurerm_resource_group , module.subnet,module.vnet]
    nsg=var.nsg
}

module "publicip"{
    source="../../modules/azurerm_publicip"
    depends_on = [ module.azurerm_resource_group ]
    public_ip = var.public_ip

}
# module "keyvalut"{
#     source="../../modules/azurerm_KEYVALUT"
#     depends_on = [ module.azurerm_resource_group ]
#     kv=var.kv
#     username = var.username

#    password = var.password
# }

# note- agr alg alg username and password variable banega secret ke liye key valut ke under tab aesa module mai pss krna hoga .
 # key valut mai comment bala jo hai oo alg alg variable ka concept hai but production mai use nhi hota .



module "keyvalut"{
    source="../../modules/azurerm_KEYVALUT"
    depends_on = [ module.azurerm_resource_group ]
    kv=var.kv
    
}
module "vm"{
   source="../../modules/azurerm_vm"
   depends_on = [ module.publicip,module.subnet ,module.keyvalut]

   VM=var.VM
    
}