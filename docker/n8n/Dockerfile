FROM docker.n8n.io/n8nio/n8n

USER root

# Решение проблемы "AI Agent медленно работает"
# @see https://community.n8n.io/t/my-ai-agent-answer-very-slow/80055/5
# @see https://github.com/n8n-io/n8n/issues/12961

RUN sed -i 's/callbacks: \[new import_N8nLlmTracing\.N8nLlmTracing(this)\]/callbacks: \[\]/' /usr/local/lib/node_modules/n8n/node_modules/@n8n/n8n-nodes-langchain/dist/nodes/llms/LMChatOpenAi/LmChatOpenAi.node.js

USER node
