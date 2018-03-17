using UnityEngine;

public class ChangeRadius : MonoBehaviour
{
    private GameController gCtrl;
    private Renderer rend;

    void Start()
    {
        rend = GetComponent<Renderer>();
        gCtrl = Camera.main.gameObject.GetComponent<GameController>();
        //UpdateRadius(gCtrl.propertyID, gCtrl.planetRadius);
		UpdateRadius(334, 100f);
    }

    void Update()
    {
        if (Input.anyKeyDown)
        {
			//UpdateRadius(334, 100f);
			//UpdateRadius(gCtrl.propertyID, gCtrl.planetRadius);
        }
    }

    void UpdateRadius(int propertyID, float planetRadius)
    {
        rend.sharedMaterial.SetFloat(propertyID, planetRadius);
    }
}
