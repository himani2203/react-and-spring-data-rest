resource = {
    naming = {
        environment = "d", region = "va2"
    }

    tags = {
        Live = "no"
        TechnicalService = "Development"
        SupportDL = "himani4141@gmail.com"
        AccessType = "Internal"
    }
}

environment = {
    metadata = {
        source = "workspace/environment/development"
        contact = "himani4141@gmail.com"

        sequence = "000"
        primary_key = "np-dev"
    }
}

app_service = [
    {
        service_plan = { size = "S1"}
        scaling_plan = {
            cpu = { max = 80, min = 30 },
            mem = { max = 80, min = 30 }
        }
        container = [
            { image = "springboot:000", port = 8080 }
        ]
    }
]