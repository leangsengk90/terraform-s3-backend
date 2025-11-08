## How to Run

* Create Remote Backend to Store State
```
cd remote-state
just clean
just init dev
just plan dev
just apply dev
```

* Destroy Remote Backend to Store State
```
just destroy 
Type: "yes"
```

* Create Lambda and Api Gateway
```
cd main
just clean
just init dev
just plan dev
just apply dev
```

* Destroy Lambda and Api Gateway
```
just destroy 
Type: "yes"
```

* Create S3 with Cloudfront
```
cd static-website
just clean
just init dev
just plan dev
just apply dev
```

* Destroy S3 with Cloudfront
```
just destroy 
Type: "yes"
```

> NOTE: Please install `just` command in your PC!
>