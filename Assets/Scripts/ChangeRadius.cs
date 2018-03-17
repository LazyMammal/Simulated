using UnityEngine;

public class ChangeRadius : MonoBehaviour
{
    private GameController gCtrl;
    private Renderer rend;
    public int propertyID;

    void Start()
    {
        rend = GetComponent<Renderer>();
		//Debug.Log(rend.material.name);
		//Debug.Log(rend.material.shader.name);
        gCtrl = Camera.main.gameObject.GetComponent<GameController>();
        propertyID = Shader.PropertyToID(gCtrl.propertyName);
        UpdateRadius(propertyID, gCtrl.planetRadius);
    }

    void LateUpdate()
    {
        if (Input.anyKeyDown)
        {
            UpdateRadius(propertyID, gCtrl.planetRadius);
	        //Debug.Log(propertyID + " " + gCtrl.propertyID + " " + rend.material.GetFloat(propertyID));
        }
    }

    void UpdateRadius(int propertyID, float planetRadius)
    {
        //rend.material.SetFloat(propertyID, planetRadius);
		//Debug.Log("HasProperty: " + rend.material.HasProperty(propertyID));
    }
}
