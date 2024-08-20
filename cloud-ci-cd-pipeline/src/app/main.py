from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import uvicorn
import boto3
from botocore.exceptions import ClientError
import os

app = FastAPI()

# DynamoDB setup
dynamodb = boto3.resource('dynamodb', region_name='us-west-2')
table = dynamodb.Table(os.environ.get('DYNAMODB_TABLE_NAME'))

class Item(BaseModel):
    id: str
    name: str
    description: str

@app.post("/items/")
async def create_item(item: Item):
    try:
        response = table.put_item(Item=item.dict())
        return {"message": "Item created successfully", "item": item}
    except ClientError as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/items/{item_id}")
async def read_item(item_id: str):
    try:
        response = table.get_item(Key={'id': item_id})
        item = response.get('Item')
        if not item:
            raise HTTPException(status_code=404, detail="Item not found")
        return item
    except ClientError as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.put("/items/{item_id}")
async def update_item(item_id: str, item: Item):
    try:
        response = table.update_item(
            Key={'id': item_id},
            UpdateExpression="set name=:n, description=:d",
            ExpressionAttributeValues={
                ':n': item.name,
                ':d': item.description
            },
            ReturnValues="UPDATED_NEW"
        )
        return {"message": "Item updated successfully", "updated_attributes": response['Attributes']}
    except ClientError as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.delete("/items/{item_id}")
async def delete_item(item_id: str):
    try:
        response = table.delete_item(Key={'id': item_id})
        return {"message": "Item deleted successfully"}
    except ClientError as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)