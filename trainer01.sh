#!/bin/bash

# Functions for colors
bold() {
    echo -e "\033[1m$1\033[0m"
}

green() {
    echo -e "\033[32m$1\033[0m"
}

red() {
    echo -e "\033[31m$1\033[0m"
}

cyan() {
    echo -e "\033[36m$1\033[0m"
}

yellow() {
    echo -e "\033[33m$1\033[0m"
}

# ASCII Art and title
clear
yellow "============================================"
yellow " CKAD Trainer - Interactive CKAD Simulator "
yellow "============================================"
echo ""

# Function to verify a solution
verify_solution() {
    local verify_command="$1"
    local expected_output="$2"
    local output=$(eval "$verify_command" 2>/dev/null)
    if [[ "$output" == "$expected_output" ]]; then
        green "✅ Correct! You can proceed to the next question."
        return 0
    else
        red "❌ Incorrect. Try again."
        return 1
    fi
}

# Question 1
bold "\nQuestion 1: Create a Pod named 'nginx-pod' using the 'nginx:latest' image."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get pod nginx-pod -o jsonpath='{.spec.containers[0].image}'" "nginx:latest"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 2
bold "\nQuestion 2: Create a Deployment named 'web-app' with 3 replicas, using the 'nginx:1.21' image."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get deployment web-app -o jsonpath='{.spec.replicas}'" "3"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 3
bold "\nQuestion 3: Create a ConfigMap named 'app-config' with the key-value pair 'LOG_LEVEL=DEBUG'."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get configmap app-config -o jsonpath='{.data.LOG_LEVEL}'" "DEBUG"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 4
bold "\nQuestion 4: Create a Secret named 'db-credentials' with the key-value pair 'username=admin'."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get secret db-credentials -o jsonpath='{.data.username}' | base64 --decode" "admin"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 5
bold "\nQuestion 5: Create a Pod named 'app-pod' that mounts the ConfigMap 'app-config' and the Secret 'db-credentials' as environment variables."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get pod app-pod -o jsonpath='{.spec.containers[0].envFrom[0].configMapRef.name}'" "app-config"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 6
bold "\nQuestion 6: Create a Service of type 'ClusterIP' named 'web-service' that exposes the Deployment 'web-app' on port 80."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get service web-service -o jsonpath='{.spec.ports[0].port}'" "80"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 7
bold "\nQuestion 7: Create an Ingress named 'web-ingress' that routes traffic to the Service 'web-service' on '/app'."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get ingress web-ingress -o jsonpath='{.spec.rules[0].http.paths[0].path}'" "/app"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 8
bold "\nQuestion 8: Create a PersistentVolume named 'pv-log' with a capacity of 2Gi."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get pv pv-log -o jsonpath='{.spec.capacity.storage}'" "2Gi"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 9
bold "\nQuestion 9: Create a PersistentVolumeClaim named 'pvc-log' that requests 1Gi of storage."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get pvc pvc-log -o jsonpath='{.status.phase}'" "Bound"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 10
bold "\nQuestion 10: Create a Pod named 'log-pod' that mounts the PVC 'pvc-log' at '/var/log'."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get pod log-pod -o jsonpath='{.spec.volumes[0].persistentVolumeClaim.claimName}'" "pvc-log"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 11
bold "\nQuestion 11: Create a Job named 'data-processor' that uses the 'busybox' image and runs the command 'echo \"Processing data...\"'."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get job data-processor -o jsonpath='{.status.succeeded}'" "1"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 12
bold "\nQuestion 12: Create a CronJob named 'backup-job' that runs a Job every 5 minutes, using the 'busybox' image and the command 'echo \"Backing up data...\"'."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get cronjob backup-job -o jsonpath='{.spec.schedule}'" "*/5 * * * *"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 13
bold "\nQuestion 13: Create a Pod named 'multi-container-pod' with two containers: one using the 'nginx' image and the other using the 'busybox' image."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get pod multi-container-pod -o jsonpath='{.spec.containers[*].image}'" "nginx busybox"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 14
bold "\nQuestion 14: Create a Deployment named 'redis-deploy' with 2 replicas, using the 'redis:6.2' image, and set a memory limit of 512Mi."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get deployment redis-deploy -o jsonpath='{.spec.template.spec.containers[0].resources.limits.memory}'" "512Mi"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 15
bold "\nQuestion 15: Create a Service of type 'NodePort' named 'redis-service' that exposes the Deployment 'redis-deploy' on port 6379."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get service redis-service -o jsonpath='{.spec.ports[0].port}'" "6379"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 16
bold "\nQuestion 16: Create a Pod named 'init-pod' with an init container using the 'busybox' image and a main container using the 'nginx' image."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get pod init-pod -o jsonpath='{.spec.initContainers[0].image}'" "busybox"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 17
bold "\nQuestion 17: Create a Pod named 'security-pod' that uses the 'nginx' image and sets the security context to run as a non-root user (runAsUser: 1000)."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get pod security-pod -o jsonpath='{.spec.securityContext.runAsUser}'" "1000"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 18
bold "\nQuestion 18: Create a Pod named 'liveness-pod' that uses the 'nginx' image and configures a liveness probe on port 80."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get pod liveness-pod -o jsonpath='{.spec.containers[0].livenessProbe.httpGet.port}'" "80"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 19
bold "\nQuestion 19: Create a Pod named 'readiness-pod' that uses the 'nginx' image and configures a readiness probe on port 80."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get pod readiness-pod -o jsonpath='{.spec.containers[0].readinessProbe.httpGet.port}'" "80"; do
    read -p "Modify the solution and press Enter to verify again..."
done

# Question 20
bold "\nQuestion 20: Create a Pod named 'resource-pod' that uses the 'nginx' image and sets a CPU limit of 500m and a memory request of 256Mi."
read -p "Press Enter after completing the solution..."
while ! verify_solution "kubectl get pod resource-pod -o jsonpath='{.spec.containers[0].resources.limits.cpu}'" "500m"; do
    read -p "Modify the solution and press Enter to verify again..."
done

green "\n🎉 Congratulations! You have completed all 20 questions of the CKAD exam!"
