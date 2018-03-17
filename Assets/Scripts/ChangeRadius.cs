using UnityEngine;

public class ChangeRadius : MonoBehaviour
{
    private GameController gCtrl;
    private Renderer rend;

    void Start()
    {
        rend = GetComponent<Renderer>();
        gCtrl = Camera.main.gameObject.GetComponent<GameController>();
        UpdateRadius(gCtrl.propertyID, gCtrl.planetRadius);
    }

    void Update()
    {
        if (Input.anyKeyDown)
        {
			UpdateRadius(gCtrl.propertyID, gCtrl.planetRadius);
        }
    }

    void UpdateRadius(int propertyID, float planetRadius)
    {
        rend.material.SetFloat(propertyID, planetRadius);
    }
}
