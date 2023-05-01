resource = {
    naming = {
        environment = "d", region = "va2"
    }

    tags = {
        Live = "no"
        TechnicalService = "Development"
        SupportDL = "himani.yadav@xyz.com"
        AccessType = "Internal"
    }
}

environment = {
    metadata = {
        source = "azure-apps-services/workspace/environment/development"
        contact = "himani.yadav@xyz.com"

        sequence = "000"
        primary_key = "np-dev"
    }
}

WhiteListedCIDRRange = [ "23.34.45.56/67" ] #Please add cidr ranges

app_service = [
    {
        service_plan = { size = "P2v3"}
        scaling_plan = {
            cpu = { max = 80, min = 30 },
            mem = { max = 80, min = 30 }
        }
        container = [
            { image = "springboot:np000" }
        ]
    }
]