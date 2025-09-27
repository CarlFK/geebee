#
set -ex

host=${1:-del}

# export ANSIBLE_STRATEGY=mitogen_linear

# export ANSIBLE_ROLES_PATH=/home/carl/src/dc/debian/ansible/roles/
# above will override ./ansible.cfg:
# roles_path=


ansible-playbook \
    ansible/site.yml \
    -vvv \
    --inventory-file inventory/hosts \
    --vault-password-file ~/.ansible-vault \
    --user root --limit ${host} \

    # --tags hostname
