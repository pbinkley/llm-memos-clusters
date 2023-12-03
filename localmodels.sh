echo Model all-MiniLM-L6-v2-f16 
{ time llm cluster --database memos.db --summary --model all-MiniLM-L6-v2-f16 --truncate 750 memos 5 > cluster-output-all-MiniLM-L6-v2-f16-750.json; } 2>&1;
echo Model replit-code-v1_5-3b-q4_0
{ time llm cluster --database memos.db --summary --model replit-code-v1_5-3b-q4_0 --truncate 750 memos 5 > cluster-output-replit-code-v1_5-3b-q4_0-750.json; } 2>&1
echo Model orca-mini-3b-gguf2-q4_0
{ time llm cluster --database memos.db --summary --model orca-mini-3b-gguf2-q4_0 --truncate 750 memos 5 > cluster-output-orca-mini-3b-gguf2-q4_0-750.json; } 2>&1
echo Model mpt-7b-chat-merges-q4_0
{ time llm cluster --database memos.db --summary --model mpt-7b-chat-merges-q4_0 --truncate 750 memos 5 > cluster-output-mpt-7b-chat-merges-q4_0-750.json; } 2>&1
echo Model orca-2-7b
{ time llm cluster --database memos.db --summary --model orca-2-7b --truncate 750 memos 5 > cluster-output-orca-2-7b-750.json; } 2>&1
echo Model rift-coder-v0-7b-q4_0
{ time llm cluster --database memos.db --summary --model rift-coder-v0-7b-q4_0 --truncate 750 memos 5 > cluster-output-rift-coder-v0-7b-q4_0-750.json; } 2>&1
echo Model em_german_mistral_v01
{ time llm cluster --database memos.db --summary --model em_german_mistral_v01 --truncate 750 memos 5 > cluster-output-em_german_mistral_v01-750.json; } 2>&1
echo Model mistral-7b-instruct-v0
{ time llm cluster --database memos.db --summary --model mistral-7b-instruct-v0 --truncate 750 memos 5 > cluster-output-mistral-7b-instruct-v0-750.json; } 2>&1
echo Model mistral-7b-openorca
{ time llm cluster --database memos.db --summary --model mistral-7b-openorca --truncate 750 memos 5 > cluster-output-mistral-7b-openorca-750.json; } 2>&1
echo Model gpt4all-falcon-q4_0
{ time llm cluster --database memos.db --summary --model gpt4all-falcon-q4_0 --truncate 750 memos 5 > cluster-output-gpt4all-falcon-q4_0-750.json; } 2>&1
echo Model gpt4all-13b-snoozy-q4_0
{ time llm cluster --database memos.db --summary --model gpt4all-13b-snoozy-q4_0 --truncate 750 memos 5 > cluster-output-gpt4all-13b-snoozy-q4_0-750.json; } 2>&1
echo Model wizardlm-13b-v1
{ time llm cluster --database memos.db --summary --model wizardlm-13b-v1 --truncate 750 memos 5 > cluster-output-wizardlm-13b-v1-750.json; } 2>&1
echo Model orca-2-13b
{ time llm cluster --database memos.db --summary --model orca-2-13b --truncate 750 memos 5 > cluster-output-orca-2-13b-750.json; } 2>&1
echo Model nous-hermes-llama2-13b
{ time llm cluster --database memos.db --summary --model nous-hermes-llama2-13b --truncate 750 memos 5 > cluster-output-nous-hermes-llama2-13b-750.json; } 2>&1
echo Model starcoder-q4_0
{ time llm cluster --database memos.db --summary --model starcoder-q4_0 --truncate 750 memos 5 > cluster-output-starcoder-q4_0-750.json; } 2>&1
