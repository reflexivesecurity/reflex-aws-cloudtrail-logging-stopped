# reflex-aws-cloudtrail-logging-stopped
A reflex rule to detect when CloudTrail logging has been stopped.

## Usage
To use this rule either add it to your `reflex.yaml` configuration file:  
```
rules:
  - reflex-aws-cloudtrail-logging-stopped:
    version: latest
```

or add it directly to your Terraform:  
```
...

module "reflex-aws-cloudtrail-logging-stopped" {
  source           = "github.com/cloudmitigator/reflex-aws-cloudtrail-logging-stopped"
}

...
```

## License
This Reflex rule is made available under the MPL 2.0 license. For more information view the [LICENSE](https://github.com/cloudmitigator/reflex-aws-cloudtrail-logging-stopped/blob/master/LICENSE) 
