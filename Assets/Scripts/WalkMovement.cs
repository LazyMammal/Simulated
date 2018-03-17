using UnityEngine;

public class WalkMovement : MonoBehaviour
{
    public float speed = 5f;

    void Update()
    {
        float inputForward = Input.GetAxis("Vertical");
        float inputRight = -Input.GetAxis("Horizontal");

        Vector3 planeForward = transform.forward;
        planeForward.y = 0f;
        planeForward.Normalize();
        Vector3 planeRight = new Vector3(-planeForward.z, 0f, planeForward.x);

        Vector3 moveVec = planeForward * inputForward + planeRight * inputRight;

        Vector3 pos = transform.position;
        pos += moveVec * speed * Time.deltaTime;
        transform.position = pos;
    }
}
