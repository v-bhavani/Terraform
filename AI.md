# API Reference

REST API for AWS cost analysis, cost forecast, EC2 right-sizing, EKS cost, unused resources, security groups, good practices, and more. All `/api/*` responses use a standard envelope.

---

## Base URL and authentication

- **Base URL:** `http://localhost:8080` (or your host/port).
- **API token (optional):** If `API_TOKEN` is set, every `/api/*` request must include:
  - `Authorization: Bearer <token>` or
  - `X-API-Token: <token>`
- **Health:** `GET /health` is not protected.

---

## Response format

- **Success:** `{ "success": true, "data": { ... } }`
- **Error:** `{ "success": false, "error": "<message>" }` with HTTP 4xx/5xx.

### Optional chart/graph output

For endpoints that return chartable data, you can request graph JSON instead of the default payload:

- **Query:** `?format=chart` or `?output=graph`
- **Chart type (optional):** `?chart_type=pie|bar|line|scatter|radar|bubble|polar` (default: `bar`)

When present, `data` is a chart object: `{ "type", "label", "dataSet": [{ "label", "data", "backgroundColor" }], "options", "meta" }`. Example: `{"type":"pie","label":["Running","Completed","Failed"],"dataSet":[{"label":"Job Status Overview","data":[7,15,3],"backgroundColor":["#3cba9f","#e8c3b9","#c45850"]}]}`. Supported endpoints: `/api/cost-analysis`, `/api/cost-analysis/s3`, `/api/cost-forecast`, `/api/summary`. Without `format=chart`, the existing response structure is unchanged.

---

## Common query parameters and headers

| Purpose | Query | Header |
|--------|--------|--------|
| Region | `?region=eu-west-1` | `X-Region: eu-west-1` |
| Account (multi-account) | `?account_id=123456789012` | `X-Account-Id: 123456789012` |

- **Default region:** `us-east-1` when omitted.
- **All regions:** `?region=all` or `?region=*` to scan all EC2 regions (parallel, bounded by `MAX_CONCURRENT_REGIONS`).
- **Account:** Omit for default credentials; required when using only encrypted multi-account.

---

## POST /api/ai/query (natural language)

**Request:** `POST /api/ai/query` with `Content-Type: application/json`:

```json
{ "query": "find unused resources in all regions" }
```

**Success response (200):**

```json
{
  "success": true,
  "endpoint": "/api/unused-resources",
  "params": { "region": "all" },
  "data": { ... }
}
```

`data` is the inner payload from the routed GET endpoint. On failure or no match, `success` is `false` and `error` is set; `endpoint` and `params` may still be present. Parameters are parsed from the query text (e.g. "last 30 days" → `days=30`, "all regions" → `region=all`) and merged with any `?account_id=`, `?region=` or `X-Account-Id` / `X-Region` on the request. Routing is **spec-driven and semantic**: endpoint descriptions from the API registry are compared to the query (local term-frequency similarity by default). Set `OPENAI_API_KEY` and use an embedder-backed router for optional OpenAI `text-embedding-3-small` similarity. The server logs the selected endpoint and similarity score for each request.

---

## Endpoints

### Health

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/health` | Liveness/readiness. Returns `{"status":"ok"}`. |

### Discovery and accounts

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/endpoints` | List all available API endpoints (path, method, description, params) from the registry. For discovery by users and AI agents. |
| GET | `/api/accounts` | List configured account IDs. With default creds only: `account_ids: []`, `using_default_credentials: true`. |

### Cost

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/cost-analysis` | Cost and usage by service and region. `?days=30`, `?account_id=...` |
| GET | `/api/cost-analysis/s3` | **S3 cost breakdown** by usage type and region (see [S3 cost breakdown](#s3-cost-breakdown) below). `?days=30`, `?account_id=...` |
| GET | `/api/cost/overview` | Current & previous period totals, by service/region, change amount/percent, hidden cost breakdown. `?days=30`, `?account_id=...` |
| GET | `/api/cost-forecast` | Cost forecast for next N days. `?days=30` (max 93), `?account_id=...` |

### AI natural language query

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/ai/query` | **Natural language query router.** Send a JSON body `{"query": "..."}` (e.g. "find unused resources in all regions", "analyze aws cost last 30 days"). The backend maps the query to the correct GET endpoint, extracts parameters (days, region, account_id, tag_key, port, etc.), executes the request, and returns `{ "success", "endpoint", "params", "data" }`. Same auth as other `/api/*`; optional `?account_id=`, `?region=` or headers are merged with extracted params. |

### Summary (dashboard)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/summary` | Single-call dashboard: cost total (30d), over/under-provisioned counts, unused resources, stale keys, EKS clusters, NAT gateways. `?region=...`, `?account_id=...` (may take 1–2 min). |
| GET | `/api/ai-summary` | **AI/MCP-oriented summary:** top cost drivers, idle resources, security risks, optimization opportunities. `?region=...`, `?account_id=...`. Use for agents and dashboards. |

### EC2 and right-sizing

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/overprovisioned-vms` | EC2 with low avg CPU (default &lt; 20%). `?region=...`, `?account_id=...` |
| GET | `/api/underprovisioned-vms` | EC2 with high avg CPU (default &gt; 80%). `?region=...`, `?account_id=...` |

### Unused resources and tags

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/unused-resources` | Unattached EBS, unassociated EIPs, old EBS snapshots. `?region=...`, `?account_id=...` |
| GET | `/api/resources/by-tag?tag_key=...&tag_value=...` | Resources by tag. `tag_key` required. `?region=...`, `?account_id=...` |

### Security and good practices

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/stale-access-keys` | IAM keys not rotated within threshold. `?days=90`, `?account_id=...` |
| GET | `/api/security-groups` | Attached SGs with rules. `?region=...`, `?open_only=true`, `?account_id=...` |
| GET | `/api/instances/open-port` | Instances with a port open (default SSH 22). `?port=22`, `?open_to_world_only=true`, `?include_provisioning=true`, `?region=...`, `?account_id=...` |
| GET | `/api/good-practices` | IAM password policy, MFA status, findings. `?account_id=...` |

### EKS

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/eks/clusters` | List EKS clusters. `?region=...`, `?account_id=...` |
| GET | `/api/eks/cost` | EKS cost from Cost Explorer. `?days=30`, `?account_id=...` |

### Cost visibility

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/nat-gateways` | List NAT gateways. `?region=...`, `?account_id=...` |

### AMIs and snapshots

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/amis` | List custom AMIs (owner=self). `?region=...`, `?account_id=...` |
| GET | `/api/snapshots` | List EBS (VM) snapshots (owner=self). `?region=...`, `?account_id=...` |

### FinOps extended (cost optimization, S3, networking, compute, security, governance)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/recommendations/savings-plans` | Savings Plans purchase recommendation. `?days=7\|30\|60`, `?term=ONE_YEAR\|THREE_YEARS`, `?account_id=...` |
| GET | `/api/recommendations/reserved-instances` | Reserved Instance purchase recommendations. `?days=7\|30\|60`, `?term=ONE_YEAR\|THREE_YEARS`, `?account_id=...` |
| GET | `/api/cost-anomalies` | Cost anomalies (requires Cost Anomaly Detection). `?days=1-90`, `?account_id=...` |
| GET | `/api/cost/by-tag` | Cost grouped by tag key (requires cost allocation tags). `?days=30`, `?tag_key=Environment`, `?account_id=...` |
| GET | `/api/s3/public-buckets` | S3 buckets that allow public access. `?region=...`, `?account_id=...` |
| GET | `/api/s3/unencrypted-buckets` | S3 buckets without default encryption. `?region=...`, `?account_id=...` |
| GET | `/api/s3/buckets-without-lifecycle` | S3 buckets without lifecycle policy. `?region=...`, `?account_id=...` |
| GET | `/api/load-balancers` | ALB/NLB with target health; `idle` = no healthy targets. `?region=...`, `?account_id=...` |
| GET | `/api/ebs/volumes` | EBS volumes with size, type, cost estimate. `?region=...`, `?account_id=...` |
| GET | `/api/rds/instances` | RDS instances; `idle` when stopped or available. `?region=...`, `?account_id=...` |
| GET | `/api/lambda/functions` | Lambda functions; `high_memory` when config &gt; 1024 MB. `?region=...`, `?account_id=...` |
| GET | `/api/security-groups/unused` | Security groups not attached to any ENI. `?region=...`, `?account_id=...` |
| GET | `/api/iam/users-with-admin` | IAM users with AdministratorAccess. `?account_id=...` |
| GET | `/api/iam/roles-with-admin` | IAM roles with AdministratorAccess. `?account_id=...` |
| GET | `/api/tag-compliance` | Resources missing required tags. `?region=...`, `?tag_keys=Environment,Owner,Project,CostCenter`, `?account_id=...` |

### Governance & optimization (Trusted Advisor, Compute Optimizer, CloudWatch Logs, VPC, EIP, Backup, KMS, ECS, CloudFront, Budgets)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/trusted-advisor/checks` | Trusted Advisor check summaries (Business/Enterprise Support). `?account_id=...` |
| GET | `/api/compute-optimizer/ec2` | EC2 instance right-sizing recommendations. `?region=...`, `?account_id=...` |
| GET | `/api/compute-optimizer/ebs` | EBS volume recommendations. `?region=...`, `?account_id=...` |
| GET | `/api/compute-optimizer/lambda` | Lambda memory recommendations. `?region=...`, `?account_id=...` |
| GET | `/api/cloudwatch/log-groups` | CloudWatch Logs log groups (retention, stored bytes). `?region=...`, `?account_id=...` |
| GET | `/api/vpc-endpoints` | VPC endpoints inventory. `?region=...`, `?account_id=...` |
| GET | `/api/elastic-ips` | Elastic IPs with association status (cost visibility). `?region=...`, `?account_id=...` |
| GET | `/api/backup/vaults` | AWS Backup vaults and recovery point count. `?region=...`, `?account_id=...` |
| GET | `/api/kms/keys` | KMS keys inventory. `?region=...`, `?account_id=...` |
| GET | `/api/ecs/clusters` | ECS clusters and services inventory. `?region=...`, `?account_id=...` |
| GET | `/api/cloudfront/distributions` | CloudFront distributions (global). `?account_id=...` |
| GET | `/api/budgets` | AWS Budgets (**account_id** or **X-Account-Id** required). `?account_id=...` |

---

## S3 cost breakdown

Use `GET /api/cost-analysis/s3` to see *why* S3 costs what it does (by usage type and region). Suitable for MCP servers or dashboards.

| Item | Value |
|------|--------|
| **Method** | `GET` |
| **Path** | `/api/cost-analysis/s3` |
| **Query** | `days` (optional, 1–365). `account_id` (optional). |
| **Headers** | `Authorization: Bearer <token>` or `X-API-Token` if `API_TOKEN` set; `X-Account-Id` for multi-account. |

**Example request:**

```bash
curl -s "http://localhost:8080/api/cost-analysis/s3"
curl -s "http://localhost:8080/api/cost-analysis/s3?days=7"
curl -s -H "X-Account-Id: 123456789012" "http://localhost:8080/api/cost-analysis/s3?days=30"
```

**Success response (200):** `data` contains:

| Field | Type | Description |
|-------|------|-------------|
| `start_date` | string | Period start (YYYY-MM-DD). |
| `end_date` | string | Period end (YYYY-MM-DD). |
| `total_cost` | string | Total S3 cost in USD. |
| `by_usage_type` | array | `{ "usage_type": "...", "amount": "..." }` per row. |
| `by_region` | array | `{ "region": "...", "amount": "..." }` per row. |

**Example:**

```json
{
  "success": true,
  "data": {
    "start_date": "2025-02-03",
    "end_date": "2025-03-04",
    "total_cost": "244.29",
    "by_usage_type": [
      { "usage_type": "TimedStorage-ByteHrs", "amount": "120.50" },
      { "usage_type": "Requests-Tier1", "amount": "45.20" },
      { "usage_type": "DataTransfer-Out-Bytes", "amount": "78.59" }
    ],
    "by_region": [
      { "region": "us-east-1", "amount": "180.00" },
      { "region": "eu-west-1", "amount": "64.29" }
    ]
  }
}
```

**Usage type examples:** `TimedStorage-ByteHrs` = Standard storage; `TimedStorage-ByteHrs-IA` = Infrequent Access; `Requests-Tier1` / `Requests-Tier2` = GET/PUT requests; `DataTransfer-Out-Bytes` = egress. Per-bucket cost requires [Cost Allocation Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in AWS Billing.

---

## Example API calls

```bash
# Health
curl -s http://localhost:8080/health

# With API token
curl -s -H "Authorization: Bearer YOUR_API_TOKEN" "http://localhost:8080/api/cost-analysis"
curl -s -H "X-API-Token: YOUR_API_TOKEN" "http://localhost:8080/api/cost-analysis"

# Accounts
curl -s "http://localhost:8080/api/accounts"

# Summary (dashboard)
curl -s "http://localhost:8080/api/summary"
curl -s "http://localhost:8080/api/summary?region=eu-west-1"

# Cost
curl -s "http://localhost:8080/api/cost-analysis"
curl -s "http://localhost:8080/api/cost-analysis?days=7&account_id=123456789012"
curl -s "http://localhost:8080/api/cost/overview?days=30"
curl -s "http://localhost:8080/api/cost-analysis/s3?days=30"
curl -s "http://localhost:8080/api/cost-forecast?days=30"

# EC2 right-sizing
curl -s "http://localhost:8080/api/overprovisioned-vms"
curl -s "http://localhost:8080/api/underprovisioned-vms?region=eu-west-1"

# Unused resources and tags
curl -s "http://localhost:8080/api/unused-resources?region=all"
curl -s "http://localhost:8080/api/resources/by-tag?tag_key=Environment&tag_value=production"

# Security
curl -s "http://localhost:8080/api/security-groups?open_only=true"
curl -s "http://localhost:8080/api/instances/open-port?port=22&open_to_world_only=true"
curl -s "http://localhost:8080/api/good-practices"
curl -s "http://localhost:8080/api/stale-access-keys?days=90"

# EKS, NAT, AMIs, snapshots
curl -s "http://localhost:8080/api/eks/clusters"
curl -s "http://localhost:8080/api/eks/cost?days=30"
curl -s "http://localhost:8080/api/nat-gateways"
curl -s "http://localhost:8080/api/amis?region=eu-west-1"
curl -s "http://localhost:8080/api/snapshots?region=all"
```

---

## Configuration (env vars relevant to API)

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | `8080` | HTTP server port. |
| `WRITE_TIMEOUT` | `5m` | Max response write time. |
| `API_TOKEN` | (none) | If set, required for `/api/*`. |
| `AWS_REGION` | `us-east-1` | Default region. |
| `COST_ANALYSIS_DAYS` | `30` | Default days for cost endpoints. |
| `CPU_LOW_THRESHOLD` | `20` | CPU % below = over-provisioned. |
| `CPU_HIGH_THRESHOLD` | `80` | CPU % above = under-provisioned. |
| `STALE_KEY_DAYS` | `90` | Access key age (days) for stale. |
| `MAX_CONCURRENT_REGIONS` | `10` | Max regions in parallel for `region=all`. |

---

## IAM permissions

The identity used (env creds or decrypted per-account) must have at least:

- **Cost Explorer:** `ce:GetCostAndUsage`, `ce:GetCostForecast`
- **EC2:** `ec2:DescribeInstances`, `ec2:DescribeVolumes`, `ec2:DescribeAddresses`, `ec2:DescribeSnapshots`, `ec2:DescribeImages`, `ec2:DescribeSecurityGroups`, `ec2:DescribeNetworkInterfaces`, `ec2:DescribeNatGateways`
- **CloudWatch:** `cloudwatch:GetMetricStatistics`
- **Resource Groups Tagging:** `tag:GetResources`
- **IAM:** `iam:ListUsers`, `iam:ListAccessKeys`, `iam:GetAccessKeyLastUsed`, `iam:GetAccountPasswordPolicy`, `iam:ListMFADevices`
- **EKS:** `eks:ListClusters`, `eks:DescribeCluster`, `eks:ListNodegroups` (optional)

Cost Explorer and IAM are account-scoped; EC2/CloudWatch/EKS/Tagging are region-scoped.
 
