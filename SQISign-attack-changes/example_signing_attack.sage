"""
Example usage of the attack vectors
"""

# Python imports
import time

# Local imports
from SQISign import SQISign
from utilities import print_info


# SQISign is a protocol between a signer and verifier
signer = SQISign()
verifier = SQISign()

# Message that we want to sign
msg = b"Learning to SQI!"

print_info("Starting SQISign Signing")
sqisign_time = time.time()

# The signer generates a keypair and sends
# their public key to the verifier
print_info("Computing Keypair")
signer.keygen()
EA = signer.export_public_key()

# Given a message, the signer makes a commitment and sends
# the codomain of the commitment isogeny ψ : E0 → E1. Then,
# a challenge is derived deterministically from the message
# and a response is made to this challenge
print_info("Signing Message")
sig = signer.sign(msg)

# The verifier deterministically creates the same challenge
# and then validates the signature S
print_info("Validating signature")
valid = verifier.verify(EA, sig, msg)

print_info(f"Signing example worked: {valid}")
print_info(f"Signing took {time.time() - sqisign_time:5f}")
