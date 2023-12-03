This is a simple llm embeddings project, used as a demo in a workshop in November 2023. It is intended to demonstrate some of the potential for researchers in running a large language on a local workstation. It uses Simon Willison's very convenient Python library [llm](https://github.com/simonw/llm), and is based on Willison's [llm-cluster example](https://simonwillison.net/2023/Sep/4/llm-embeddings/#llm-cluster). Where Willison processes all the readme files on his laptop, this simpler example uses a small collection of memoranda, which are provided in the ```memos``` directory. This project includes a shell script that runs the sample texts through each of the models available to the ```llm``` app and captures timing data.

- TODO: extend this to use ```llm```'s online services as well

## Steps

### Set up

- Download or clone this repository.
- Install llm: ```pip install llm```
- Install llm-gpt4all: ```llm install llm-gpt4all``` - this lets llm run local models
- Install llm-cluster: ```llm install llm-cluster```
- Install llm-sentence-transformers: ```llm install llm-sentence-transformers```
- Register a sentence-transformer: ```llm sentence-transformers register all-MiniLM-L6-v2```

The texts of 28 memos are in .txt files in the ```memos``` directory. llm-cluster wants to receive them in the form of a json file, with each memo represented by a hash with an ```id``` field and a ```text``` field. This is provided in ```memos.json``` (which was produced by ```scripts/jsonify.py```). So, we're ready to go.

### Running

We need to compile the embeddings into a collection called ```memos``` and into a convenience database, which we'll call ```memos.db``` (note: if ```memos.db``` already exists, you need to delete or rename it). We do this by piping ```memos.json``` into ```llm embed-multi```. 

```
cat memos.json \
| llm embed-multi memos - \
    --database memos.db \
    --model sentence-transformers/all-MiniLM-L6-v2 \
    --store
```

Note: if you get an error that includes this: 

> ```UserWarning: CUDA initialization: Unexpected error from cudaGetDeviceCount(). Did you run some cuda functions before calling NumCudaDevices() that might have already set an error?```

Then you need to tell PyTorch not to try to use your GPU. You do this by setting an environment variable: ```export CUDA_VISIBLE_DEVICES="0"```)

We can now generate clusters:

```
llm cluster memos --database memos.db 5 > cluster-output.json
```

(The "5" at the end tells it how many clusters we want.) This sends the output to a file called ```cluster-output.json```, containing the five clusters. 

We can get more benefit from the LLM by having it generate summaries for the clusters, based on the content of the memos included in each cluster. We do that by adding ```--summary``` to the command, and pipe the output to a new file:

```
llm cluster memos --database memos.db 5 --summary --model orca-2-7b --truncate 750 > cluster-output-with-summary.json
```
We are truncating the text that gets used for clustering to 750 characters, which seems to be a value that allows all of the clusters to be processed by most models. You can tinker with this value.

Note: the summaries are generated using the default prompt; there is scope to improve them using a custom prompt, which can be passed with a ```--prompt``` argument.

Note: to get useful summaries you need to use a bigger model. This example uses orca-2-7b, but you'll get better results if you can use one of the 13b models (which use 16gb of memory), such as gpt4all-13b-snoozy-q4_0.

Note: the output json currently reverses the ```id``` and ```content``` tags - so you need to open it in a text editor and search and replace them - change ```"id":``` to ```"idx":``` (but only for the memos, not for the clusters), then change ```"content":``` to ```"id":```, then change ```"idx":``` to ```"content":```.

Now generate an HTML page to make it easier to browse:

```
python3 scripts/htmlize.py cluster-output-with-summary.json
```

## Pre-generated outputs

This repository includes pregenerated clusterings for each of the fifteen local models available with ```llm``` (run ```llm models list``` to see the current list). The outputs, in json and in browsable html, are in the ```750-json```, so called because the contents were generated with truncation to 750 characters. The batch was run with ```localmodels.sh```. 

Information about the models and about the run time for the generation of ```750-json``` are in [```modes.csv```](https://github.com/pbinkley/llm-memos-clusters/blob/main/models.csv). The columns ```real```, ```user``` and ```sys``` contain the values generate by the Linux ```time``` utility, representing the clock time of the run, the CPU time used in user space (which might be longer than the clock time if multiple cores were used in parallel), and CPU time used in system space, respectively. The job was run on a Windows 11 machine using the Linux subsystem; the machine has 32.0 GB of RAM and an i7-9700 CPU @ 3.00GHz. All processing was done by the CPU; a data-capable GPU was not available.
