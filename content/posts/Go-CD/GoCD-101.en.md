---
title: "GoCD-101 - Free and Open Source CI/CD"
date: 2020-05-24T12:55:08+05:30
lastmod: 2020-03-06T21:29:01+08:00
draft: true

author: "Kishore Devaraj"
description: "This article talks the basic idea of Go-CD deployment pipeline, its internal components and how it works"

tags: ["go-cd", "deployment"]
categories: ["devops"]
featuredImage: "/images/go-cd-101/go-cd-cover.svg"
---
<!--more-->


## What is GoCD?
Go-CD is the open source CI/CD server which helps the software development teams to stream line the integration and deployment
process by providing interactive UI to configure their workflows.

It comes up with wide range of features such as
- End to end visualisation
- Pipeline as code
- Build complex workflow with ease and clarity
- Supports both parallelization and serialization
- Integrations with popular cloud platform such as kubernetes, docker and AWS

and all of them works out of box without any additional installation of plugins. GoCD follows master-slave architecture
for communications between the components.

## Installation and Setup
In order to run GoCD in our pipeline, we need two prominent components. **go-server** and **go-agent**.
You can find the installation instructions of both them in the offical GoCD [docs](https://www.gocd.org/download/).
Make sure you have ***java > 11*** for the latest GoCD versions. If you already have one that is lower than 11 and want
to manage multiple java version in your system, this try this tool called [jenv](https://www.jenv.be/).

## Go-Server and Go-Agent
{{< image src="/images/go-cd-101/gocd-server-and-agents.svg"
caption="Server and Agents"
width=500
>}}
<br></br>

In the GoCD ecosystem, the server is the one that controls everything, assign the tasks and
provides the user interface to users of the system.
The agents are the ones that do any work (run commands, do deployments, etc) that is configured by the users.

## Main components in GoCD
{{< image src="/images/go-cd-101/gocd-main-components.svg"
caption="Components in Pipeline"
width=700
>}}
<br></br>

From the above picture we can see there are lot of components involved in modelling the workflow, lets discuss
from the bottom to top.

#### Task
The smallest unit of all is Task. A task is typically a **single command** configured to run as a part of the job it is in.
Not every task needs to be a simple command, since tasks can be plugins too.
<br></br>

#### Jobs
A job is a **sequential collection of tasks** and each task will run one after the other in a sequential manner,
so if a task fails, none of the tasks following that one get executed and the job is then considered to have "failed".
The most important aspect of a job is that a single agent has to pick up and finish a job.
<br></br>

#### Stage
A stage is a **non sequential collection of jobs**.
Different agents can pick each stage and run it parallel and so, they have to be independent of each other.
This is where we can achieve concurrency in GoCD if we have enough agents.
<br></br>

#### Pipeline
A pipeline is a representation of **workflow or a part of a workflow**.
For instance, if you are trying to automatically run tests, build and then deploy an application to an environment
then those steps can be modeled as a pipeline.
<br></br>

#### Materials
At last there is one more component called Material which is the **source and trigger point** for the pipeline.
The Material can be either a version systems (git, mercury) or even a another pipeline.
<br></br>

## Advanced features of GO-CD
### Value Stream Map
Value Stream Map is another important feature of GoCD which provides **end-to-end visualisation from commit to deployment**.
- It provides level of ***abstraction*** in modelling, allows you to hide the underneath stuff and shows only the overall picture.
- Also using artifacts(output generated in a stage)and pipeline dependencies we can ***build binaries once*** and use it throughout the pipeline.
- It also useful when we need to trace out where exactly something went wrong.

Following image contains the sample *Value Stream Map* of a release pipeline of an App.

<br></br>
{{<image src="/images/go-cd-101/app-vsm.png"
caption="Value Stream Map"
>}}
<br></br>

### Fan-Out and Fan-In
A pipeline (or material) is said to be fan-out, when this pipeline is **dependency for multiple downstream pipelines**.
This brings in the advantages of parallelization and quicker feedback, which is a key goal of Continuous Delivery.
On contradictory, a pipeline (or material) is said to be fan-in when its has **multiple dependency on other upstream pipelines**.
<br></br>
{{<image src="/images/go-cd-101/fan-out-fan-in.svg"
caption="Fan-Out and Fan-In"
width=600
>}}

## Conclusion
The features we have discussed is a just a tip of an iceberg, there are so many other cool features such as *Pipelines as Code,
Elastic Agent, Users and Role Management, Server Configuration* etc.
You can checkout all those in [GoCD docs](https://docs.gocd.org/current/)