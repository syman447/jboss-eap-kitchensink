if [ -z "$AUTH_TOKEN" ]; then
  AUTH_TOKEN=`cat /var/run/secrets/kubernetes.io/serviceaccount/token`
fi

if [ -e /run/secrets/kubernetes.io/serviceaccount/ca.crt ]; then
  alias oc="oc -n $PROJECT --token=$AUTH_TOKEN --server=$OPENSHIFT_API_URL --certificate-authority=/run/secrets/kubernetes.io/serviceaccount/ca.crt "
else
  alias oc="oc -n $PROJECT --token=$AUTH_TOKEN --server=$OPENSHIFT_API_URL --insecure-skip-tls-verify "
fi

echo "Promoting deployment"
tag_results=`oc tag --source=istag ${SRC_ISTAG} ${PROJECT}/${DST_ISTAG}`

echo $tag_results
