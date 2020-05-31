---
title: "GoCD-101 - Free and Open Source CI/CD"
date: 2020-05-24T12:55:08+05:30
lastmod: 2020-05-30T21:29:01+08:00
draft: false

author: "Kishore Devaraj"
description: "This article talks the basic idea of Go-CD deployment pipeline, its internal components and how it works"

tags: ["go-cd", "deployment"]
categories: ["devops"]
featuredImage: "/images/go-cd-101/go-cd-cover.svg"
---
<!-- The following line is added to use the description, as a summary in the homepage list,
 I know it's doesn't make much sense. But this is one of the way suggested by the theme author
 -->

<!--more-->
<br></br>
## A Brief Prologue
Before diving into this article, just a short foreword on why this website was created and its motive behind it.
For a very long time, I was planning to write down on things that I learn. But unfortunately me being a *chronic procrastinator*,
that was a "A dream that ~~never~~(not anymore) come true".

#### So what made it possible now?
Actually, there is no single concrete reason. But the covid-19 lockdown, boredom that comes along with it,
passion and curiosity towards tech, made this feasible. Going forward I plan write down on the things I learn.

Enough of Trivia! Let jump into the article.

## Introduction
In this article, lets see what is GoCD, features it provides and its internal components, which are
all the core concepts you need to understand before actually creating a pipeline in GoCD.
I'm not covering how to set up pipelines, actual coding or any other practical stuffs (That would be too vast).


## What is GoCD?
Go-CD is the open source CI/CD server which helps the software development teams to stream line the integration and deployment
process by providing interactive UI to configure their workflows. It was cross-platform in nature and mainly return in
java and ruby. Initially it was a product of Thoughtworks studio and later it was open sourced. GoCD is a not another
CI pipeline that we see on the market, it is meant for continuous delivery. Here **deployment pipeline is treated as the first
class** citizen to avoid all the common headache we have will setup our deployments in CI.

It comes up with wide range of features such as
- End to end visualisation
- Pipeline as code
- Build complex workflow with ease and clarity
- Supports both parallelization and serialization
- Native integrations with popular cloud platform such as kubernetes, docker and AWS

and all of them works out of box without any additional installation of plugins. GoCD also supports wide range of plugins to support other platforms and it's extensible in nature.

{{< admonition type=info title="Architecture Type" open=true >}}
GoCD follows master-slave architecture for communications between the components.
{{< /admonition >}}
<br></br>

## Go-Server and Go-Agent
{{< image src="/images/go-cd-101/gocd-server-and-agents.svg"
caption="Server and Agents"
width=500
>}}


In the GoCD architecture, there are two main components which is bare minimum to run the GoCD pipeline.
#### Go-Server
- Go-server is the one that **controls everything, assign the job and provides the user interface** to users of the system.
- User usually interacts with server to define the pipelines and tells what to run next.
- It assigns the job to go-agent and store the artifacts once it's done.

#### Go-Agent
- The agents are the ones that **do any work (run commands, do deployments, etc)** that is configured by the users.
- There can be 'N' number of agents each opens up a port to listen for a job from the go-server.
- There is also concept called *'Resources'* in go-agent. Each go-agent can have a set of resource such (macOS, python, git) installed in it.
- So whenever the user wants to run a particular task in a particular environment (say macOS), he can add plain text tag to the job.
- The server will only allocated that job to the agent if it satisfies all the tags.
<br></br>

## Main components in GoCD
{{< image src="/images/go-cd-101/gocd-main-components.svg"
caption="Components in Pipeline"
width=700
>}}

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
You can checkout all those in [GoCD docs](https://docs.gocd.org/current/).
So that's all you need to know for setting up a Go-CD pipeline.

Happy Deployment!