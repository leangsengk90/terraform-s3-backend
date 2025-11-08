## How to Run

* Create Remote Backend to Store State
```
cd remote-state
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
cd main
just init dev
just plan dev
just apply dev
```

* Destroy S3 with Cloudfront
```
just destroy 
Type: "yes"
```

><span style="color:#ff5555"> NOTE:</span> Please install `just` command in your PC!
>