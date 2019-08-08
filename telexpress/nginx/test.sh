# Retrieve ingress public ip

INGRESS_IP=$(kubectl get svc -n istio-system istio-ingressgateway -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')

# Test all three backends
# Interval 1.5 seconds, timeout 1 second

watch -n 2 "\
echo ; curl -s -m 0.5 http://$INGRESS_IP/v1/labels.html ; \
echo '\n\n' ; curl -m 0.5 -s http://$INGRESS_IP/v2/labels.html ; \
echo '\n\n' ; curl -m 0.5 -s http://$INGRESS_IP/v3/labels.html"
